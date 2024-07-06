class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        # :omniauth, omniauth_providers: [:google_oauth2]
  has_many :outputs, dependent: :destroy
  has_many :sources, dependent: :destroy
end
