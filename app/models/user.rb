
class User < ActiveRecord::Base
  has_many :cats
  has_many :cat_rental_requests

  after_initialize :ensure_session_token

  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true}


  # validates :password
  attr_reader :password

  def self.find_by_credentials(user_name, password)
    @user =  User.find_by(user_name: user_name)

    return nil unless @user

    if @user.is_password?(password)
      @user
    else
      flash.now[:errors] = @user.errors.full_messages
      nil
    end
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def is_owner?(id)
    !self.cats.nil? && self.cats.where(id: id).length == 1
  end


  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end


  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end

  def generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  private
  def ensure_session_token
    self.session_token ||= generate_session_token
  end
end
