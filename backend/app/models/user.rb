require 'bcrypt'

class User < ApplicationRecord
  include BCrypt
  has_many :entries
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  attribute :password, :string
  before_save :encrypt_password
  before_create :generate_token

  def self.authenticate(email, password)
    user = self.find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  # Generate token for user
  def generate_token
    token_gen = SecureRandom.hex
    self.token = token_gen
    token_gen
  end
end
