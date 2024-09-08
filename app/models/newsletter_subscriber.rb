class NewsletterSubscriber < ApplicationRecord
  validates :email, presence: true, uniqueness: true
end
