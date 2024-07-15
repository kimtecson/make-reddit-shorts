class Output < ApplicationRecord
  has_one_attached :video
  belongs_to :user
  belongs_to :source
  belongs_to :batch
  accepts_nested_attributes_for :source
end
