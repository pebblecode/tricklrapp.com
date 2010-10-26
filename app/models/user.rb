class User < ActiveRecord::Base
  has_many :authentications
  has_many :tweets, :order => 'scheduled_at DESC'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me

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
