require 'json'
require 'streamio-ffmpeg'
require_relative 'video_downloader'

class VideoEdit
  def generate(source, settings)
    gen_start = Time.now
    Rails.logger.info "Starting video generation..."

    output_path = Rails.root.join('app', 'services', 'outputs', 'output.mp4').to_s
    File.delete(output_path) if File.exist?(output_path)

    edit_video(source, settings)

    gen_end = Time.now
    Rails.logger.info "Video generation completed."
    Rails.logger.info "Video generated in #{gen_end - gen_start} seconds"

    output_path
  end

  def edit_video(source, settings)
    subtitles = create_subs
  
    source.file.open do |tempfile|
      movie = FFMPEG::Movie.new(tempfile.path)
  
      subtitle_preset = settings[:subtitle_preset]
  
      # Define subtitle options based on preset
      case subtitle_preset
      when 'Vanilla'
        font_color = 'ffffff'
        font_border_color = '000000'
        font_border_width = 5
        font_size = 48
        font = 'neue'
      when 'Yellow'
        font_color = 'ffffff'
        font_border_color = 'f0c424'
        font_border_width = 3
        font_size = 48
        font = 'bangers'
      when 'Red'
        font_color = 'ffffff'
        font_border_color = 'ff0000'
        font_border_width = 3
        font_size = 48
        font = 'bangers'
      else
        font_color = 'ffffff'
        font_border_color = '000000'
        font_border_width = 5
        font_size = 48
        font = 'bangers'
      end
      increase_font_size_animation = 6
  
      # Calculate the delay based on the first subtitle start time
      first_subtitle_start = subtitles.first[:start] + 3
      audio_delay = (first_subtitle_start * 1000).to_i  # Convert to milliseconds
  
      # Build subtitle filter
      drawtext_options = subtitles.map do |subtitle|
        subtitle_text = subtitle[:text].gsub("'", "''")  # Escape single quotes properly
  
        %{
          drawtext=text='#{subtitle_text}':
          fontcolor=0x#{font_color}:
          bordercolor=#{font_border_color}:
          borderw=#{font_border_width}:
          fontsize='#{font_size}+#{increase_font_size_animation}*if(between(t,#{subtitle[:start] + 3},#{subtitle[:start] + 3}+0.1),(t-#{subtitle[:start] + 3})*10,if(between(t,#{subtitle[:end] + 3}-0.1,#{subtitle[:end] + 3}),(#{subtitle[:end] + 3}-t)*10,1))':
          fontfile=app/services/resources/#{font}.ttf:
          box=0:
          boxcolor=black@1:
          boxborderw=5:
          x=(w-text_w)/2:
          y=(h-text_h)/2:
          enable='between(t,#{subtitle[:start] + 3},#{subtitle[:end] + 3})'
        }.gsub(/\s+/, ' ').strip
      end.join(',')
  
      # Image overlay with subtitle filter
      image_path = Rails.root.join('app', 'services', 'outputs', 'title_image.png').to_s
      output_video_path = Rails.root.join('app', 'services', 'outputs', 'output.mp4').to_s
  
      # Add the path to the new audio clip for the beginning
      title_audio_path = Rails.root.join('app', 'services', 'resources', 'speech_title.mp3').to_s
  
      # Construct the FFmpeg command
      ffmpeg_command = %W(
        ffmpeg
        -i #{tempfile.path}
        -i #{title_audio_path}
        -i app/services/resources/speech.mp3
        -i #{image_path}
        -filter_complex "[0:v]#{drawtext_options},overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:enable='between(t,0,3)'[v]; 
        [1:a]adelay=0|0,asetpts=PTS-STARTPTS[a1]; 
        [2:a]adelay=#{audio_delay}|#{audio_delay},asetpts=PTS-STARTPTS[a2]; 
        [a1][a2]amix=inputs=2[a]"
        -map "[v]" -map "[a]" -c:v libx264 -c:a aac -strict experimental -t 10 #{output_video_path}
      ).join(' ')
  
      puts "Executing FFmpeg command: #{ffmpeg_command}"
      system(ffmpeg_command)
    end
  end
  
  
  
  

  private

  def create_subs
    file_path = Rails.root.join('app', 'services', 'resources', 'transcription_with_timestamps.json')
    file = File.read(file_path)
    data = JSON.parse(file)

    words = data["words"]
    subtitles = []

    words.each_with_index do |word, i|
      if i == 0 || word["word"].length >= 3 || i == words.length - 1
        subtitles << {
          text: word["word"],
          start: word["start"],
          end: words[i + 1] ? words[i + 1]["start"] : word["end"]
        }
      else
        subtitles.last[:text] += " #{word["word"]}"
        subtitles.last[:end] = words[i + 1] ? words[i + 1]["start"] : word["end"]
      end
    end

    subtitles
  end
end
