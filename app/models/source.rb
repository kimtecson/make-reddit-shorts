class Source < ApplicationRecord
  belongs_to :user
  has_many :batches
end
