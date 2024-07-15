class OutputsController < ApplicationController
  include Rails.application.routes.url_helpers

  def new
    @output = Output.new
    @source = Source.new
  end

  def create
    Rails.logger.info "Entering create action in OutputsController"
    @output = Output.new(output_params)
    @output.source = Source.find_by(user_id: current_user.id)
    @output.user_id = current_user.id
    @batch = Batch.first
    @output.batch_id = @batch.id

    respond_to do |format|
      if @output.save
        Rails.logger.info "Output saved successfully with reddit_post_url: #{@output.reddit_post_url}"
        Rails.logger.info "About to generate video"
        begin
          video_path = VideoGen.generate(@output)
          Rails.logger.info "Video generated at path: #{video_path}"

          if video_path.is_a?(String) && File.exist?(video_path)
            @output.video.attach(io: File.open(video_path),
                                 filename: "output.mp4",
                                 content_type: 'video/mp4')

            @output.url = url_for(@output.video) if @output.video.attached?
            @output.save

            format.html { redirect_to @output, notice: 'Output was successfully created and video generated.' }
            format.json { render json: @output, status: :created }
          else
            Rails.logger.error "Invalid video path returned: #{video_path}"
            @output.errors.add(:base, "Error generating video")
            format.html { render :new }
            format.json { render json: @output.errors, status: :unprocessable_entity }
          end
        rescue => e
          Rails.logger.error "Error in video generation: #{e.message}"
          Rails.logger.error e.backtrace.join("\n")
          @output.errors.add(:base, "Error generating video: #{e.message}")
          format.html { render :new }
          format.json { render json: @output.errors, status: :unprocessable_entity }
        end
      else
        Rails.logger.info "Output failed to save. Errors: #{@output.errors.full_messages}"
        format.html { render :new }
        format.json { render json: @output.errors, status: :unprocessable_entity }
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
    params.require(:output).permit(:reddit_post_url)
  end
end
