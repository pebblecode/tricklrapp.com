class User < ActiveRecord::Base

  #-------------------------------------
  # Filters
  #-------------------------------------
  after_create :create_settings

  #-------------------------------------
  # Set up devise
  #-------------------------------------
  devise :rememberable, :omniauthable

  #-------------------------------------
  # Relationships
  #-------------------------------------
  has_many :authentications
  has_many :statuses, :order => 'scheduled_at DESC'
  has_many :unpublished_statuses,
    :class_name => "Status",
    :order => 'scheduled_at DESC',
    :conditions => ['published_at IS NULL']
  has_many :published_statuses,
    :class_name => "Status",
    :order => 'scheduled_at DESC',
    :conditions => ['published_at IS NOT NULL']
  has_one :setting

  #-------------------------------------
  # Attributes accessible
  #-------------------------------------
  attr_accessible :nickname, :name, :remember_me

  #-------------------------------------
  # Validations
  #-------------------------------------
  validates :name,
    :length => { :within => 1..255, :allow_blank => true }
  validates :nickname,
    :length => { :within => 1..255, :allow_blank => true }

  #-------------------------------------
  # Applies omniauth response to the User model
  #-------------------------------------
  def self.find_for_twitter_oauth(omniauth, signed_in_resource=nil)
    logger.info(omniauth.to_yaml)
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])

    if authentication && authentication.user
      user = authentication.user
      user.update_timezone(omniauth['extra']['raw_info']['time_zone'])
      user.update_omniauth_login(authentication, omniauth)

      user
    else
      user = User.create!(:nickname => omniauth['info']['nickname'],
                          :name => omniauth['info']['name'])
      user.authentications.create!(:provider => omniauth['provider'],
                                   :uid => omniauth['uid'],
                                   :token => omniauth['credentials']['token'],
                                   :secret => omniauth['credentials']['secret'])
      user.save
      user.update_timezone(omniauth['extra']['raw_info']['time_zone'])
      return user
    end
  end

  #-------------------------------------
  # Creates settings for a new user
  #-------------------------------------

  def update_omniauth_login(authentication, omniauth)
    authentication.token = omniauth['credentials']['token']
    authentication.secret = omniauth['credentials']['secret']
    authentication.save
  end

  def time_zone
    setting.time_zone || Rails.configuration.time_zone
  end

  def update_timezone(time_zone)
    setting.time_zone = time_zone
    setting.save
  end

  private
    def create_settings
      # A default value of 7200 seconds (2 hours) is set on interval in the db
      # so we don't need to declare it here
      self.setting = Setting.new
      self.save!
    end
end
