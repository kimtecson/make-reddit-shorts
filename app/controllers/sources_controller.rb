class SourcesController < ApplicationController

  def new
    @source = Source.new
  end
  def create
    @source = Source.new(source_params)
    @source.user = current_user
    @source.url = 'test_url'

    if @source.save
      respond_to do |format|
        format.html { redirect_to @source, notice: 'Video uploaded successfully.' }
        format.json { render json: { success: true, message: 'Video uploaded successfully' }, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: { success: false, errors: @source.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

  def source_params
    params.require(:source).permit(:file)
  end
end
