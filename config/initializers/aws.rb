require 'aws-sdk-s3' # or require any other service you're using

Aws.config.update({
  region: 'us-west-2', # Set your AWS region
  credentials: Aws::SharedCredentials.new
})
