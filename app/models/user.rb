class User < ActiveRecord::Base
  
  #-------------------------------------
  # Filters
  #-------------------------------------
  after_create :create_settings
  
  #-------------------------------------
  # Set up devise
  #-------------------------------------
  devise :database_authenticatable, :omniauthable

  #-------------------------------------
  # Relationships
  #-------------------------------------
  has_many :authentications
  has_many :statuses, :order => 'scheduled_at DESC'
  has_many :unpublished_statuses, :class_name => "Status", :order => 'scheduled_at DESC', :conditions => ['published_at IS NULL']
  has_many :published_statuses, :class_name => "Status", :order => 'scheduled_at DESC', :conditions => ['published_at IS NOT NULL']
  has_one :setting

  #-------------------------------------
  # Validations
  #-------------------------------------
  validates :email,
    :length => { :within => 1..255, :allow_blank => true }
  validates :screen_name,
    :length => { :within => 1..255, :allow_blank => true }
  validates :profile_image_url,
    :length => { :within => 1..255, :allow_blank => true }

  #-------------------------------------
  # Applies omniauth response to the User model
  #-------------------------------------
  def apply_omniauth(omniauth)
    self.screen_name = omniauth['extra']['user_hash']['screen_name'] if screen_name.blank?
    self.profile_image_url = omniauth['extra']['user_hash']['profile_image_url'] if profile_image_url.blank?
    authentications.build(
      :provider => omniauth['provider'], 
      :uid => omniauth['uid'],
      :token => omniauth['credentials']['token'],
      :secret => omniauth['credentials']['secret'])
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
