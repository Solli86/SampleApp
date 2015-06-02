class User < ActiveRecord::Base
  before_save { email.downcase! }
  #name validation
  validates(
    :name,    
    presence: true,
    length: { minimum: 3, maximum: 50 }
  )
  # Email validation
  VALID_EMAIL_REGEX = /[a-z\d\+-.]+@[a-z\d\-]+[.]{1}[a-z]+\z/i  
  validates(
    :email,  
    presence: true,
    length: {minimum: 8, maximum: 255},
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  )
  #passwors section
  validates :password, length: { minimum: 6 }
  has_secure_password
end
