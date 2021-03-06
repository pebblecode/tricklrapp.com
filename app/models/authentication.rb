class Authentication < ActiveRecord::Base

  #-------------------------------------
  # Relationships
  #-------------------------------------
  belongs_to :user

  #-------------------------------------
  # Validations
  #-------------------------------------
  validates :user_id,
    :presence => true, 
    :numericality => true
  validates :provider,
    :presence => true,
    :length => { :within => 1..255, :allow_blank => true }
  validates :uid,
    :presence => true,
    :length => { :within => 1..255, :allow_blank => true }
  validates :token,
    :presence => true,
    :length => { :within => 1..255, :allow_blank => true }
  validates :secret,
    :presence => true,
    :length => { :within => 1..255, :allow_blank => true }
end
