class Source < ApplicationRecord
  belongs_to :user #Why should source belong to user, let's implement that later maybe (stan)
  validates :user_id, presence: true
  # has_many :batches Why many batches? Shouldn't sources and everything else be separate? (stan)
end
