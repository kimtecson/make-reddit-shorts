require 'fileutils'
include ActionView::Helpers::AssetUrlHelper

puts '[AWS] Checking sources'

source_amount = 0
urls = []
filenames = []

# Configure AWS credentials
Aws.config.update({
  region: 'eu-north-1',
  credentials: Aws::Credentials.new(
    Rails.application.credentials.dig(:aws, :access_key_id), 
    Rails.application.credentials.dig(:aws, :secret_access_key)
  )
})

# Create an S3 client
s3_client = Aws::S3::Client.new

# Set your bucket name
bucket_name = Rails.application.credentials.dig(:aws, :bucket)

# Create a presigner
presigner = Aws::S3::Presigner.new(client: s3_client)

# Ensure the local video directory exists
video_directory = Rails.root.join('app', 'services', 'resources', 'videos')
FileUtils.mkdir_p(video_directory) unless File.directory?(video_directory)

begin
  # List objects in the bucket with prefix 'source'
  response = s3_client.list_objects_v2(bucket: bucket_name, prefix: 'source')

  # Check if any objects were found
  if response.contents.empty?
    puts "[AWS] No files found starting with 'source'."
  else
    response.contents.each do |object|
      file_name = object.key.split('/').last
      filenames << file_name

      # Download the video and save it locally
      file_path = File.join(video_directory, file_name)

      puts "[AWS] Downloading #{file_name} to #{file_path}"

      File.open(file_path, 'wb') do |file|
        s3_client.get_object({ bucket: bucket_name, key: object.key }, target: file)
      end

      source_amount += 1

      # Associate the local file path with the source
      source = Source.new
      source.url = file_path # Saving local file path instead of S3 URL
      puts '[SOURCE SEED] Saving source...'
      if source.save
        puts '[SOURCE SEED] Source saved!'
      else
        puts source.errors.full_messages
      end
    end
  end
rescue Aws::Errors::ServiceError => e
  puts "[AWS] An error occurred: #{e.message}"
end

puts "[AWS] Found and saved #{source_amount} sources"
