require 'net/http'
require 'json'
require 'aws-sdk-s3'
require 'httparty'

class Whispr
  def initialize
    Aws.config.update({
      region: 'eu-north-1',
      credentials: Aws::Credentials.new(
        Rails.application.credentials.dig(:aws, :access_key_id),
        Rails.application.credentials.dig(:aws, :secret_access_key)
      )
    })


    assembly_secret = Rails.application.credentials.dig(
        :assemblyai,
        :api_key
      )

    @s3 = Aws::S3::Resource.new
    @bucket = @s3.bucket(Rails.application.credentials.dig(:aws, :bucket))
    @base_url = "https://api.deepgram.com/v1/listen"
    @headers = {
      "Authorization" => assembly_secret,
      "Content-Type" => "application/json"
    }
  end

  def create_subs
    file = 'app/services/resources/speech.mp3'
    obj = @bucket.object(File.basename(file))
  
    # Upload file to S3
    obj.upload_file(file)
  
    # Generate a presigned URL if the bucket is private
    upload_url = obj.presigned_url(:get)
    puts "Uploaded file URL: #{upload_url}"
  
    # Prepare and send request to new API
    response = send_transcription_request(upload_url)
  
    if response.nil?
      raise "No response received from the API"
    end
  
    puts "Response code: #{response.code}"
    puts "Response body: #{response.body}"
  
    if response.is_a?(Net::HTTPSuccess)
      transcription_result = JSON.parse(response.body)
      puts "Transcription result: #{transcription_result.inspect}"
  
      if transcription_result["results"]
        transcript = transcription_result["results"]["channels"].first["alternatives"].first["transcript"]
        duration = transcription_result["metadata"]["duration"]
        words = transcription_result["results"]["channels"].first["alternatives"].first["words"]
  
        save_transcription_with_timestamps(words, transcript, duration)
      else
        raise "No transcription results found"
      end
    else
      raise "Failed to start transcription: #{response.body}"
    end
  end
  

  private

  def send_transcription_request(url)
    uri = URI.parse(@base_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri, @headers)
    request.body = { "url" => url, "smart_format" => true, "language" => "en", "model" => "nova-2" }.to_json

    begin
      response = http.request(request)
      puts "Request sent successfully"
      response
    rescue StandardError => e
      puts "Error sending request: #{e.message}"
      nil
    end
  end

  def save_transcription_with_timestamps(words, transcript, duration)
    file_path = 'app/services/resources/transcription_with_timestamps.json'
    begin
      formatted_transcription = {
        "task" => "transcribe",
        "language" => "english",
        "duration" => duration,
        "text" => transcript,
        "words" => words.map do |word|
          {
            "word" => word["word"],
            "start" => word["start"],
            "end" => word["end"]
          }
        end
      }
  
      File.open(file_path, 'w') do |file|
        file.write(JSON.pretty_generate(formatted_transcription))
      end
  
      puts "Transcription with timestamps saved to #{file_path}"
    rescue StandardError => e
      puts "Error saving transcription to file: #{e.message}"
    end
  end  
end
