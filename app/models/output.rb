class Output < ApplicationRecord
  has_one_attached :video
  belongs_to :user
  belongs_to :source
  belongs_to :batch
end
