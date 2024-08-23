class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  normalizes :email, with: ->(email) { email.strip.downcase }

  generates_token_for :password_reset, expires_in: 15.minutes do
    # TODO: Where is password_salt defined?
    password_salt&.last(10)
  end

  # TODO: implement email confirmations
  generates_token_for :email_confirmation, expires_in: 24.hours do
    email
  end
end
