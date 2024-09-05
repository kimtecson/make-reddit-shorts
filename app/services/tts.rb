require 'net/http'
require 'uri'
require 'json'

class Tts

  def generate_voice_script(settings)
    script_text = settings[:script]

    Aws.config.update({
      region: 'eu-central-1',
      credentials: Aws::Credentials.new(Rails.application.credentials.dig(
                    :aws,
                    :access_key_id
                  ), Rails.application.credentials.dig(
                    :aws,
                    :secret_access_key
                  ))
    })
    # SSML text with increased speaking rate
    ssml_text = "<speak><prosody rate='#{settings[:voice_speed]}'>#{script_text}</prosody></speak>"
    Rails.logger.info(ssml_text)
    # Create a Polly client
    polly = Aws::Polly::Client.new

    # Set up the parameters for the speech synthesis
    response = polly.synthesize_speech({
      output_format: "mp3",
      text: ssml_text,
      text_type: "ssml",
      voice_id: "#{settings[:voice_preset]}",
      engine: "neural"
    })

    # Save the audio stream to a file
    File.open("app/services/resources/speech.mp3", "wb") do |file|
      file.write(response.audio_stream.read)
    end

    puts "Audio file 'speech.mp3' has been created."
  end

  def generate_voice_title(settings)
    title_text = File.read('app/services/resources/title.txt')

    Aws.config.update({
      region: 'eu-central-1',
      credentials: Aws::Credentials.new(Rails.application.credentials.dig(
                    :aws,
                    :access_key_id
                  ), Rails.application.credentials.dig(
                    :aws,
                    :secret_access_key
                  ))
    })
    # SSML text with increased speaking rate
    ssml_text = "<speak><prosody rate='#{settings[:voice_speed]}'>#{title_text}</prosody></speak>"
    # Create a Polly client
    polly = Aws::Polly::Client.new

    # Set up the parameters for the speech synthesis
    response = polly.synthesize_speech({
      output_format: "mp3",
      text: ssml_text,
      text_type: "ssml",
      voice_id: "#{settings[:voice_preset]}",
      engine: "neural"
    })

    # Save the audio stream to a file
    File.open("app/services/resources/speech_title.mp3", "wb") do |file|
      file.write(response.audio_stream.read)
    end

    puts "Audio file 'speech_title.mp3' has been created."
  end


end
