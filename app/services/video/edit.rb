require 'json'
require 'streamio-ffmpeg'


# Create a new class to hold all the methods
class VideoGenerator
  # def initialize(input_video_path, output_video_path, audio_path)
  #   '/app/assets/videos/sample.mp4' = input_video_path
  #   @output_video_path = output_video_path
  #   '/app/assets/videos/sample.mp3' = audio_path
  # end

  def edit_video()
    subtitles = create_subs()
    movie = FFMPEG::Movie.new('app/assets/videos/sample.mp4')

    # Settings for subtitles
    font_color = 'FFFFFF'
    font_border_color = '000000'
    font_border_width = 5
    increase_font_size_animation = 6

    drawtext_options = subtitles.map do |subtitle|
      subtitle_text = subtitle[:text].gsub("'", "")  # Escape single quotes in the subtitle text because it breaks the FFmpeg command

      start = subtitle[:start]
      end_time = subtitle[:end]

      # Drawtext filter with animation
      drawtext_filter = %{
        drawtext=text='#{subtitle_text}':fontcolor=0x#{font_color}:bordercolor=#{font_border_color}:borderw=#{font_border_width}:fontsize='36+#{increase_font_size_animation}*if(between(t,#{start},#{start}+0.1),(t-#{start})*10,if(between(t,#{end_time}-0.1,#{end_time}),(#{end_time}-t)*10,1))':fontfile=video/resources/font.ttf:box=0:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/2:y=(h-text_h)/2:enable='between(t,#{start},#{end_time})'
      }.strip

      drawtext_filter
    end.join(',')

    # Prepare FFmpeg command without image overlay
    ffmpeg_command = %W(
      ffmpeg -i app/assets/videos/sample.mp4
      -i app/assets/audio/speech.wav
      -filter_complex "#{drawtext_options}"
      -map 0:v:0 -map 1:a:0 -c:v libx264 -c:a aac -strict experimental -shortest app/assets/videos/output.mp4
    ).join(' ')

    system(ffmpeg_command)
  end

  private

  def create_subs
    file = File.read('app/assets/tts/transcription_with_timestamps.json')
    data = JSON.parse(file)

    # Process the words array
    subtitles = []
    words = data["words"]

    i = 0
    while i < words.length
      if i + 1 < words.length && words[i]["word"].length < 3 && words[i + 1]["word"].length >= 3
        # Include the next word if the current word's length < 3
        group = [words[i], words[i + 1]]
        i += 2  # Move to the next pair
      else
        # Otherwise, just include the current word
        group = [words[i]]
        i += 1  # Move to the next word
      end

      # Adjust end time dynamically
      if i < words.length
        group[-1]["end"] = words[i]["start"]  # Set end time of current word to start time of next word
      end

      subtitles << {
        text: group.map { |word| word["word"] }.join(' '),
        start: group.first["start"],
        end: group.last["end"]
      }
    end
    return subtitles
  end
end
