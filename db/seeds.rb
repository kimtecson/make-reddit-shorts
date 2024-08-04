include ActionView::Helpers::AssetUrlHelper

puts '[AWS] Checking sources'

source_amount = 0
urls = []
filenames = []

# Configure AWS credentials
Aws.config.update({
  region: 'eu-north-1',
  credentials: Aws::Credentials.new(Rails.application.credentials.dig(
                    :aws,
                    :aws_access_key_id
                  ), Rails.application.credentials.dig(
                    :aws,
                    :aws_secret_access_key
                  ))
})

# Create an S3 client
s3_client = Aws::S3::Client.new

# Set your bucket name
bucket_name = Rails.application.credentials.dig(
                    :aws,
                    :aws_bucket_name
                  )

# Create a presigner
presigner = Aws::S3::Presigner.new(client: s3_client)

begin
  # List objects in the bucket with prefix 'source'
  response = s3_client.list_objects_v2(bucket: bucket_name, prefix: 'source')

  # Check if any objects were found
  if response.contents.empty?
    puts "[AWS] No files found starting with 'source'."
  else
    response.contents.each do |object|
      file_name = object.key
      filenames << file_name

      # Generate a presigned URL for each file
      presigned_url = presigner.presigned_url(
        :get_object,
        bucket: bucket_name,
        key: file_name,
        expires_in: 3600 # URL expiration time in seconds (1 hour in this case)
      )

      source_amount += 1
      urls << presigned_url

      puts "[AWS] Presigned URL for #{file_name}:"
      puts "[AWS] #{presigned_url}"
      puts "\n"
    end
  end
rescue Aws::Errors::ServiceError => e
  puts "[AWS] An error occurred: #{e.message}"
end

puts "[AWS] Found #{source_amount} sources"

source_amount.times do |i|
  puts "[AWS] Creating new source..."
  source = Source.new
  source.url = urls[i]

  # Download the image content
  puts ['[AWS] Downloading source from s3...']
  downloaded_image = URI.open(urls[i])
  tempfile = Tempfile.new(['downloaded_image', File.extname(filenames[i])])
  IO.copy_stream(downloaded_image, tempfile.path)

  source.file.attach(io: File.open(tempfile.path), filename: filenames[i])

  puts '[SOURCE SEED] Saving source...'
  if source.save
    puts '[SOURCE SEED] Source saved!'
  else
    puts source.errors.full_messages
  end

  tempfile.close
  tempfile.unlink
end
