class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :tos, :privacy, :pricing, :send_feedback ]

  def home
    @user = current_user
  end

  def send_feedback
    sender = params[:email]
    subject = params[:subject]
    message = params[:message]

    @error_occurred = false
    begin
      FeedbackMailer.send_feedback(sender, subject, message).deliver_later
    rescue StandardError => e
      puts e
      #flash[:alert] = "Failed to send email: #{e.message}"
      @error_occurred = true
    end
    turbo_stream
  end

  def tos
  end

  def privacy
  end

  def pricing
  end
end
