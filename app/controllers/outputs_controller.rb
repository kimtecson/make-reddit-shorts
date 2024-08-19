class OutputsController < ApplicationController
  include Rails.application.routes.url_helpers

  def new
    @output = Output.new
    @sources = Source.all
  end

  def create
    Rails.logger.info "Entering create action in OutputsController"
    Rails.logger.info "Params received: #{params.inspect}"

    @output = Output.new(output_params)
    @output.user_id = current_user.id
    @query = session[:query] = params[:query]

    settings = {
      subtitle_preset: @output.subtitle_preset,
      voice_preset: @output.voice_preset,
      voice_speed: @output.voice_speed,
      script: @output.script
    }

    success = false

    ActiveRecord::Base.transaction do
      begin
        video_path = VideoGen.generate(@output, @output.source, settings)
        Rails.logger.info "Video generated at path: #{video_path}"

        if video_path.is_a?(String) && File.exist?(video_path)
          if @output.save
            @output.video.attach(io: File.open(video_path),
                                  filename: "output.mp4",
                                  content_type: 'video/mp4')

            @output.url = url_for(@output.video)
            @output.save!

            success = true
            Rails.logger.info "Output saved successfully with ID: #{@output.id}"
          else
            Rails.logger.info "Output failed to save. Errors: #{@output.errors.full_messages}"
          end
        else
          Rails.logger.error "Invalid video path returned: #{video_path}"
          @output.errors.add(:base, "Error generating video")
        end
      rescue => e
        Rails.logger.error "Error in video generation: #{e.message}"
        Rails.logger.error e.backtrace.join("\n")
        @output.errors.add(:base, "Error generating video: #{e.message}")
      end
    end

    respond_to do |format|
      if success
        format.html { redirect_to output_path(@output), notice: 'Output was successfully created.' }
        format.json { render json: { redirect_url: output_path(@output) }, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @output.errors.full_messages }, status: :unprocessable_entity }
      end
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
    params.require(:output).permit(:reddit_post_url, :source_id, :subtitle_preset, :voice_preset, :voice_speed, :script)
  end
end