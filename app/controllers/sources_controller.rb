class SourcesController < ApplicationController
  def create
    Rails.logger.info "Params: #{params.inspect}"
    Rails.logger.info "File attached?: #{params[:source][:file].present?}"

    @source = Source.new(source_params)
    @source.user_id = current_user.id

    if @source.save
      Rails.logger.info "Source saved. File attached?: #{@source.file.attached?}"

      # Generate the path for the attached file
      if @source.file.attached?
        path = rails_blob_path(@source.file, only_path: true)
        @source.update(url: path)
      end

      render json: { success: true, message: "File uploaded successfully", url: @source.url }, status: :created
    else
      Rails.logger.info "Source errors: #{@source.errors.full_messages}"
      render json: { success: false, errors: @source.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def source_params
    params.require(:source).permit(:file)
  end
end
