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
  def self.find_for_twitter_oauth(omniauth)
    logger.info(omniauth)
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication && authentication.user
      authentication.user
    else
      user = User.create!(:nickname => omniauth['user_info']['nickname'], 
                          :name => omniauth['user_info']['name'])
      user.authentications.create!(:provider => omniauth['provider'], 
                                   :uid => omniauth['uid'],
                                   :token => omniauth['credentials']['token'],
                                   :secret => omniauth['credentials']['secret'])
      user.save
      user
    end
  end

  #-------------------------------------
  # Creates settings for a new user
  #-------------------------------------
  def create_settings
    # A default value of 7200 is set on interval in the db
    # so we don't need to delcare it here
    self.setting = Setting.new
    self.save!
  end
end
