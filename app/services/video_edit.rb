require 'json'
require 'streamio-ffmpeg'

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

    # Use the local video file path stored in the source
    Rails.logger.info("Using local video file: #{source.url}")
    local_video_path = source.url

    begin
      
      movie = FFMPEG::Movie.new(local_video_path)

      # Define subtitle options based on the provided settings
      subtitle_preset = settings[:subtitle_preset]
      font_color, font_border_color, font_border_width, font_size, font = get_font_settings(subtitle_preset)
      increase_font_size_animation = 6

      # Calculate the delay for audio based on the first subtitle start time
      first_subtitle_start = subtitles.first[:start] + 3
      audio_delay = (first_subtitle_start * 1000).to_i  # Convert to milliseconds

      # Build the FFmpeg drawtext options for subtitles
      drawtext_options = build_drawtext_options(subtitles, font_color, font_border_color, font_border_width, font_size, increase_font_size_animation, font)

      # Paths for resources
      image_path = Rails.root.join('app', 'services', 'outputs', 'title_image.png').to_s
      output_video_path = Rails.root.join('app', 'services', 'outputs', 'output.mp4').to_s
      title_audio_path = Rails.root.join('app', 'services', 'resources', 'speech_title.mp3').to_s


      # Construct the FFmpeg command
      def get_audio_duration(file_path)
        cmd = "ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 #{file_path}"
        stdout, _stderr, _status = Open3.capture3(cmd)
        stdout.strip
      end

      title_audio_duration = get_audio_duration(title_audio_path)
      speech_audio_duration = get_audio_duration('app/services/resources/speech.mp3')

      # Find the maximum duration between the two audio files
      audio_duration = [title_audio_duration.to_f, speech_audio_duration.to_f].max

      ffmpeg_command = %W(
        ffmpeg
        -y
        -i #{local_video_path}
        -i #{title_audio_path}
        -i app/services/resources/speech.mp3
        -i #{image_path}
        -filter_complex "[0:v]scale=1080:1920,fps=24,#{drawtext_options},overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:enable='between(t,0,3)'[v];
                        [1:a]adelay=0|0,asetpts=PTS-STARTPTS[a1];
                        [2:a]adelay=#{audio_delay}|#{audio_delay},asetpts=PTS-STARTPTS[a2];
                        [a1][a2]amix=inputs=2[a]"
        -map "[v]" -map "[a]" -c:v libx264 -crf 28 -preset veryfast -c:a aac -b:a 128k -shortest
        -to #{audio_duration} #{output_video_path}
        -threads 8
        -tune fastdecode
      ).join(' ')

      system(ffmpeg_command)
      
      
      
      

      Rails.logger.info "Executing FFmpeg command: #{ffmpeg_command}"
      system(ffmpeg_command)
    rescue => e
      Rails.logger.error "Error during video editing: #{e.message}"
      raise
    end
  end

  private

  # Font settings based on subtitle preset
  def get_font_settings(subtitle_preset)
    case subtitle_preset
    when 'Vanilla'
      ['ffffff', '000000', 5, 96, 'bangers']
    when 'Yellow'
      ['ffffff', '000000', 3, 96, 'bangers']
    when 'Red'
      ['ffffff', '000000', 3, 96, 'bangers']
    else
      ['ffffff', '000000', 5, 96, 'bangers']
    end
  end

  # Build the FFmpeg drawtext options based on subtitle data
  def build_drawtext_options(subtitles, font_color, font_border_color, font_border_width, font_size, increase_font_size_animation, font)
    subtitles.map do |subtitle|
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
  end

  # Parse and create subtitle data from the transcription JSON file
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
