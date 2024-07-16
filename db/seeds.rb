
include ActionView::Helpers::AssetUrlHelper

# Generate the URL for the video
puts '[SOURCE SEED] Fetching sample.mp4...'
video_url = ActionController::Base.helpers.asset_path('sample.mp4', type: :video)
# Create a new source with the video URL
puts '[SOURCE SEED] Creating new source...'
source = Source.new
source.url = video_url
source.user_id = 1

puts '[SOURCE SEED] Saving source...'
if source.save
  puts '[SOURCE SEED] Source saved!'
else
  puts source.errors.full_messages
end

# Create a new batch
puts '[BATCH SEED] Creating new batch...'
batch = Batch.new
batch.source_id = source.id
puts '[BATCH SEED] Saving batch...'
if batch.save
  puts '[BATCH SEED] Batch saved!'
else
  puts batch.errors.full_messages
end
