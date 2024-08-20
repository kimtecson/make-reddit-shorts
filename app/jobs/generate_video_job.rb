class GenerateVideoJob < ApplicationJob
    queue_as :default
  
    def perform(output_id)
      output = Output.find(output_id)
      settings = {
        subtitle_preset: output.subtitle_preset,
        voice_preset: output.voice_preset,
        voice_speed: output.voice_speed,
        script: output.script
      }
  
      ActiveRecord::Base.transaction do
        begin

          video_path = VideoGen.generate(output, output.source, settings)
          Rails.logger.info "Video generated at path: #{video_path}"
  
          if video_path.is_a?(String) && File.exist?(video_path)
            output.video.attach(io: File.open(video_path),
                                filename: "output.mp4",
                                content_type: 'video/mp4')
  
            output.url = Rails.application.routes.url_helpers.url_for(output.video)
            output.status = 'completed'
            output.save!
  
            Rails.logger.info "Output saved successfully with ID: #{output.id}"
          else
            Rails.logger.error "Invalid video path returned: #{video_path}"
            output.errors.add(:base, "Error generating video")
          end
        rescue => e
          Rails.logger.error "Error in video generation: #{e.message}"
          Rails.logger.error e.backtrace.join("\n")
          output.errors.add(:base, "Error generating video: #{e.message}")
          raise ActiveRecord::Rollback
        end
      end
    end
  end
  