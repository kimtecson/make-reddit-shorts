class Source < ApplicationRecord
  belongs_to :user #Why should source belong to user, let's implement that later maybe (stan)
  validates :user_id, presence: true
  has_one_attached :file

  # validates :file, presence: true
  # has_many :batches Why many batches? Shouldn't sources and everything else be separate? (stan)


  after_save :debug_file_attachment

  private

  def debug_file_attachment
    if file.attached?
      puts "File attached successfully"
      puts "Blob ID: #{file.blob.id}"
      puts "Blob key: #{file.blob.key}"
      puts "Blob filename: #{file.blob.filename}"
    else
      puts "File not attached"
    end
  end
end
