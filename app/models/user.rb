class User < ApplicationRecord
  attr_reader :password

  validates :username, :session_token, :password_digest, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true
  after_initialize :ensure_session_token

  has_many :subs,
    foreign_key: :mod_id,
    class_name:  :Sub,
    dependent:   :destroy

  has_many :posts,
    foreign_key: :author_id,
    class_name:  :Post,
    dependent:   :destroy

  has_many :comments,
    foreign_key: :author_id,
    class_name:  :Comment,
    dependent:   :destroy
    
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user && user.is_password?(password) ? user : nil
  end
  
  def self.generate_uniq_session_token
    token = SecureRandom::urlsafe_base64(16)
    token = SecureRandom::urlsafe_base64(16) while User.exists?(session_token: token)
    token
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_uniq_session_token
  end

  def reset_session_token!
    self.session_token = self.class.generate_uniq_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
