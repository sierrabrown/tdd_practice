class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  before_validation :set_session_token
  
  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    
    if user
      return user if user.is_password?(password)
    end
    nil
  end
  
  def password=(password)
    self[:password_digest] = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self[:password_digest]).is_password?(password)
  end
  
  has_many :goals
  
  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end
  
  #NO NOT TESTING THIS YET
  def reset_session_token!
    self[:session_token] = self.class.generate_session_token
    self.save!
  end
  
  private
  def set_session_token
    self[:session_token] ||= self.class.generate_session_token
  end
  
end