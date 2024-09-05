class User < ApplicationRecord
  # Include default devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :outputs, dependent: :destroy

  # Validate email: check for disposable, valid MX records
  validates :email, presence: true, 'valid_email_2/email': { disposable: true, mx: true, message: 'must be a valid email address' }
  
  validates :password, confirmation: true

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
      user = User.create(
        email: data['email'],
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end
end
