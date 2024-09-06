class VideoGen
  def self.generate(output, source, settings)
    total_start_time = Time.now

    reddit_post_url = output.reddit_post_url
    Rails.logger.info "Generating video for Reddit post: #{reddit_post_url}"

    output.update_column(:progress, 0)
    reddit = RedditPost.new
    reddit.write_script(reddit_post_url)
    reddit.write_title(reddit_post_url)
    Rails.logger.info "Reddit post fetched"

    output.update_column(:progress, 20)
    tts = Tts.new
    tts.generate_voice_script(settings)
    tts.generate_voice_title(settings)

    output.update_column(:progress, 35) 
    whispr = Whispr.new
    whispr.create_subs

    output.update_column(:progress, 50) 
    title = Title.new
    title.overlay_texts_on_image
    
    output.update_column(:progress, 60) 
    video_edit = VideoEdit.new
    video_path = video_edit.generate(source, settings) # specify which source to generate video with

    output.update_column(:progress, 100) # Step 4: Video generation complete
    total_end_time = Time.now
    Rails.logger.info "Total video generation time: #{total_end_time - total_start_time} seconds"

    video_path
  end
end
