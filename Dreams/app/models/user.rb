class User < ApplicationRecord
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password
    def find_by_credentials(username, password)
      user = User.find_by(username: username)
      user && user.is_password?(password) ? user : nil
    end

    def is_password?(password)
      BCrypt::Password.new(self.password_digest).is_password?(password)


      # bcrypt_pw = BCrypt::Password.new(self.password_digest)
      # bcrypt_pw.is_password?(password)
    end

    def self.generate_session_token
      SecureRandom::urlsafe_base64(16)
    end

    def password=(password)
      @password = password
      self.password_digest = BCrypt::Password.create(password)
    end

    def ensure_session_token
      self.session_token ||= self.class.generate_session_token
    end

    def reset_session_token!
      self.session_token = self.class.generate_session_token
      self.save!
      self.session_token
    end

end