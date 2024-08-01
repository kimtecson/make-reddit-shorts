
class VideoDownloader
  MAX_RETRIES = 3
  CHUNK_SIZE = 1024 * 1024  # 1 MB

  def self.download(url, destination_path, headers = {})
    full_url = url.start_with?('http') ? url : "http://localhost:3000#{url}"

    puts "Attempting to download from URL: #{full_url}"

    retries = 0
    begin
      download_with_resume(full_url, destination_path, headers)
      puts "Video downloaded successfully to #{destination_path}"
    rescue OpenURI::HTTPError => e
      puts "HTTP Error downloading video: #{e.message}"
      puts "Response body: #{e.io.read}" if e.io.respond_to?(:read)
    rescue Timeout::Error, Errno::ETIMEDOUT => e
      if retries < MAX_RETRIES
        retries += 1
        puts "Timeout error. Retrying (#{retries}/#{MAX_RETRIES})..."
        sleep(2**retries)  # Exponential backoff
        retry
      else
        puts "Max retries reached. Download failed."
      end
    rescue StandardError => e
      puts "Unexpected error: #{e.message}"
      puts e.backtrace.join("\n")
    end
  end

  def self.download_with_resume(url, destination_path, headers = {})
    temp_file = "#{destination_path}.temp"
    file_size = File.size(temp_file) if File.exist?(temp_file)

    if file_size
      headers['Range'] = "bytes=#{file_size}-"
      puts "Resuming download from byte #{file_size}"
    end

    options = {
      'User-Agent' => 'Ruby/VideoDownloader',
      :read_timeout => 300,  # 5 minutes
      :open_timeout => 300   # 5 minutes
    }.merge(headers)

    URI.open(url, options) do |input|
      File.open(temp_file, file_size ? 'ab' : 'wb') do |output|
        while (buffer = input.read(CHUNK_SIZE))
          output.write(buffer)
          print "."  # Progress indicator
        end
      end
    end

    FileUtils.mv(temp_file, destination_path)
    puts "\nDownload complete!"
  end
end

# Usage:
# VideoDownloader.download(url, '/path/to/save/video.mp4', {'Authorization' => 'Bearer your-token-here'})
