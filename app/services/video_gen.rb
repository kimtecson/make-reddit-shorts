require_relative 'video_edit.rb'
require_relative 'tts.rb'
require_relative 'whispr.rb'
require_relative 'reddit.rb'

class VideoGen
  def self.generate(output, source, font_settings)
    total_start_time = Time.now

    reddit_post_url = output.reddit_post_url
    Rails.logger.info "Generating video for Reddit post: #{reddit_post_url}"

    reddit = RedditPost.new
    reddit.write_script(reddit_post_url)
    Rails.logger.info "Reddit post fetched"


    tts = TTS.new
    tts.generate_voice


    whispr = Whispr.new
    whispr.create_subs

    video_edit = VideoEdit.new
    video_path = video_edit.generate(source, font_settings) # specify which source to gen video with


    total_end_time = Time.now
    Rails.logger.info "Total video generation time: #{total_end_time - total_start_time} seconds"

    video_path
  end
end

# # # Initialize classes

# # Start total timer


# # Get reddit post
# puts "Getting Reddit post"
# reddit_start_time = Time.now
# get_post.write_script()
# reddit_end_time = Time.now
# puts "Reddit post fetched in #{reddit_end_time - reddit_start_time} seconds"

# # Generate TTS voice
# puts "Generating TTS voice"
# tts_start_time = Time.now
# generate_voice.generate_voice()
# tts_end_time = Time.now
# puts "TTS voice generated in #{tts_end_time - tts_start_time} seconds"

# # Generate subtitles
# puts "Generating subtitles"
# subs_start_time = Time.now
# generate_subs.create_subs()
# subs_end_time = Time.now
# puts "Subtitles generated in #{subs_end_time - subs_start_time} seconds"

# # Edit video
# puts "Editing video"
# video_edit_start_time = Time.now
# video_editor.edit_video()
# video_edit_end_time = Time.now
# puts "Video edited in #{video_edit_end_time - video_edit_start_time} seconds"

# # # End total timer
# # total_end_time = Time.now
# # puts "Total time taken: #{total_end_time - total_start_time} seconds"
