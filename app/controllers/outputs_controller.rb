class OutputsController < ApplicationController
  def new
    @output = Output.new
  end

  def create
    Rails.logger.info "Entering create action in OutputsController"
    @output = Output.new
    @output.source = Source.first
    @output.user = User.first
    @output.batch = Batch.first


    if @output.save
      Rails.logger.info "Output saved successfully, about to generate video"
      video_path = VideoGenerator.generate(@output)
      Rails.logger.info "Video generated at path: #{video_path}"
      @output.video.attach(io: File.open(video_path),
                           filename: "output.mp4",
                           content_type: 'video/mp4')
      redirect_to @output, notice: 'Output was successfully created and video generated.'
    else
      render :new
    end
  end

  private

  def output_params
    params.fetch(:output, {})
  end
end
