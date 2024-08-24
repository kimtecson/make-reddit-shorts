require 'aws-sdk-s3'

s3_client = Aws::S3::Client.new(
  region: 'eu-north-1',
  credentials: Aws::Credentials.new(
    Rails.application.credentials.dig(:aws, :aws_access_key_id),
    Rails.application.credentials.dig(:aws, :aws_secret_access_key)
  )
)

bucket_name = Rails.application.credentials.dig(:aws, :aws_bucket)

begin
  response = s3_client.list_objects_v2(bucket: bucket_name)
  puts "Bucket contents: #{response.contents.map(&:key)}"
rescue Aws::Errors::ServiceError => e
  puts "Error: #{e.message}"
end
