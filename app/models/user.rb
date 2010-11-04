class User < ActiveRecord::Base
  
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

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me

  # Applies omniauth response to the User model
  def apply_omniauth(omniauth)
    self.screen_name = omniauth['extra']['user_hash']['screen_name'] if screen_name.blank?
    self.profile_image_url = omniauth['extra']['user_hash']['profile_image_url'] if profile_image_url.blank?
    authentications.build(
      :provider => omniauth['provider'], 
      :uid => omniauth['uid'],
      :token => omniauth['credentials']['token'],
      :secret => omniauth['credentials']['secret'])
  end
end
