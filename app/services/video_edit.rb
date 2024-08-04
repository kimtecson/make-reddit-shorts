require 'json'
require 'streamio-ffmpeg'
require_relative 'video_downloader'

class VideoEdit
  def generate(source, font_settings)
    gen_start = Time.now
    Rails.logger.info "Starting video generation..."

    output_path = Rails.root.join('app', 'services', 'outputs', 'output.mp4').to_s
    File.delete(output_path) if File.exist?(output_path)

    edit_video(source, font_settings)

    gen_end = Time.now
    Rails.logger.info "Video generation completed."
    Rails.logger.info "Video generated in #{gen_end - gen_start} seconds"

    output_path
  end

  def edit_video(source, font_settings)
    subtitles = create_subs

    source.file.open do |tempfile|
      movie = FFMPEG::Movie.new(tempfile.path)

      font_color = font_settings[:font_color].gsub('#', '')
      font_border_color = font_settings[:font_border_color].gsub('#', '')
      font_border_width = font_settings[:font_border_width]
      increase_font_size_animation = 6

      drawtext_options = subtitles.map do |subtitle|
        subtitle_text = subtitle[:text].gsub("'", "''")  # Escape single quotes properly

        %{
          drawtext=text='#{subtitle_text}':
          fontcolor=0x#{font_color}:
          bordercolor=#{font_border_color}:
          borderw=#{font_border_width}:
          fontsize='36+#{increase_font_size_animation}*if(between(t,#{subtitle[:start]},#{subtitle[:start]}+0.1),(t-#{subtitle[:start]})*10,if(between(t,#{subtitle[:end]}-0.1,#{subtitle[:end]}),(#{subtitle[:end]}-t)*10,1))':
          fontfile=video/resources/font.ttf:
          box=0:
          boxcolor=black@0.5:
          boxborderw=5:
          x=(w-text_w)/2:
          y=(h-text_h)/2:
          enable='between(t,#{subtitle[:start]},#{subtitle[:end]})'
        }.gsub(/\s+/, ' ').strip
      end.join(',')

      ffmpeg_command = %W(
        ffmpeg
        -i #{tempfile.path}
        -i app/services/resources/speech.wav
        -filter_complex "#{drawtext_options}"
        -map 0:v:0 -map 1:a:0
        -c:v libx264 -c:a aac
        -strict experimental
        -shortest
        app/services/outputs/output.mp4
      ).join(' ')

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
