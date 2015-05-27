class User < ActiveRecord::Base
  #name validation
  validates(
    :name,    
    presence: true,
    length: { maximum: 50 }
  )
  # Email validation
  VALID_EMAIL_REGEX = /[a-z\d\+-.]+@[a-z\d\-]+[.]{1}[a-z]+\z/i  
  validates(
    :email,  
    presence: true,
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  )
end
