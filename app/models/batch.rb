class Batch < ApplicationRecord
  belongs_to :source
  has_many :outputs
end
