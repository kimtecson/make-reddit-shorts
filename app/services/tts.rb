require 'net/http'
require 'uri'
require 'json'

class TTS

  def generate_voice(settings)
    script_text = File.open("app/services/resources/script.txt", "r").read

    Aws.config.update({
      region: 'eu-central-1',
      credentials: Aws::Credentials.new(Rails.application.credentials.dig(
                    :aws,
                    :aws_access_key_id
                  ), Rails.application.credentials.dig(
                    :aws,
                    :aws_secret_access_key
                  ))
    })
    # SSML text with increased speaking rate
    ssml_text = "<speak><prosody rate='#{settings[:voice_speed]}'>#{script_text}</prosody></speak>"
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

    puts "Audio file 'output.mp3' has been created."
  end
end
