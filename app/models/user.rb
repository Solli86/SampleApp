class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  before_save { email.downcase! }
  before_create :create_remember_token
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
  # remember token
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  def feed
    # Это предварительное решение. См. полную реализацию в "Following users".
    Micropost.where("user_id = ?", id)
  end


  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
