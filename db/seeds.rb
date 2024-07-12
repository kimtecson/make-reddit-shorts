
p 'test'
include ActionView::Helpers::AssetUrlHelper

# Generate the URL for the video
video_url = ActionController::Base.helpers.asset_path('sample.mp4')

# Create a new source with the video URL
source = Source.new
source.url = video_url

p 'no'
if source.save
  # log that it saved successfully
  Rails.logger.info "Source saved successfully with URL: #{source.url}"
  puts 'yes'
end
