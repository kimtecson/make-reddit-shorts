class OutputsController < ApplicationController
  include Rails.application.routes.url_helpers

  def new
    @output = Output.new
    @sources = Source.all
  end

  def create
    Rails.logger.info "Entering create action in OutputsController"
    Rails.logger.info "Params received: #{params.inspect}"
    Rails.logger.info "Output params: #{params[:output]}"

    @output = Output.new(output_params)
    @output.user_id = current_user.id

    Rails.logger.info "Output text color: #{@output.font_color}"
    font_settings = {
      # font_color: @output.font_color,
      # font_border_color: @output.font_border_color,
      # font_border_width: @output.font_border_width,
      # font_size: @output.font_size,
      subtitle_preset: @output.subtitle_preset

    }

    respond_to do |format|
      ActiveRecord::Base.transaction do
        Rails.logger.info "About to generate video"
        begin
          video_path = VideoGen.generate(@output, @output.source, font_settings)
          Rails.logger.info "Video generated at path: #{video_path}"

          if video_path.is_a?(String) && File.exist?(video_path)
            if @output.save
              @output.video.attach(io: File.open(video_path),
                                    filename: "output.mp4",
                                    content_type: 'video/mp4')

              @output.url = url_for(@output.video)
              @output.save!

              Rails.logger.info "Output saved successfully with reddit_post_url: #{@output.reddit_post_url}"
              format.html { redirect_to @output, notice: 'Output was successfully created and video generated.' }
              format.json { render json: @output, status: :created }
            else
              Rails.logger.info "Output failed to save. Errors: #{@output.errors.full_messages}"
              raise ActiveRecord::Rollback
            end
          else
            Rails.logger.error "Invalid video path returned: #{video_path}"
            @output.errors.add(:base, "Error generating video")
            raise ActiveRecord::Rollback
          end
        rescue => e
          Rails.logger.error "Error in video generation: #{e.message}"
          Rails.logger.error e.backtrace.join("\n")
          @output.errors.add(:base, "Error generating video: #{e.message}")
          raise ActiveRecord::Rollback
        end
      end

      if @output.errors.any?
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @output.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  rescue => e
    Rails.logger.error "Error in create action: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    respond_to do |format|
      format.html { render :new, status: :internal_server_error }
      format.json { render json: { error: e.message }, status: :internal_server_error }
    end
  end

  def show
    @output = Output.find(params[:id])
  end

  def index
    @outputs = Output.all
  end

  private

  def output_params
    params.require(:output).permit(:reddit_post_url, :source_id, :subtitle_preset)
  end
end
