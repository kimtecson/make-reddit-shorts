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
    @user = current_user
    @query = session[:query] = params[:query]

    # if @user.role == 'free'
    #   flash[:notice] = 'test'
    #   return
    # end

    if @output.save
      # Enqueue the background job to generate the video
      @output.status = 'generating'
      @output.save!
      GenerateVideoJob.perform_later(@output.id)
      
      Rails.logger.info "Output record created and video generation job enqueued with Output ID: #{@output.id}"

      respond_to do |format|
        format.html { redirect_to output_path(@output), notice: 'Output was successfully created. Video generation in progress.' }
        format.json { render json: { redirect_url: output_path(@output) }, status: :created }
      end
    else
      Rails.logger.info "Output failed to save. Errors: #{@output.errors.full_messages}"

      respond_to do |format|
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

  def progress
    output = Output.find(params[:id])
    render json: { progress: output.progress }
  end

  def video_url
    output = Output.find(params[:id])
    if output.progress == 100 && output.url.present?
      render json: { url: output.url }
    else
      render json: { error: "Video not ready yet" }, status: :unprocessable_entity
    end
  end

  

  private

  def output_params
    params.require(:output).permit(:reddit_post_url, :source_id, :subtitle_preset, :voice_preset, :voice_speed, :script)
  end
end
