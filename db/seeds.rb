# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

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
