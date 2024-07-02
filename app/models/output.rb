class Output < ApplicationRecord
  belongs_to :user
  belongs_to :source
  belongs_to :batch
end
