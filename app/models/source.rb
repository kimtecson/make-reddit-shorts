class Source < ApplicationRecord

  has_one_attached :file
  validates :file, presence: true

  after_save :debug_file_attachment

  def to_s
    # Replace this with whatever attributes best describe your Source
    "Source ##{id}"
  end

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
