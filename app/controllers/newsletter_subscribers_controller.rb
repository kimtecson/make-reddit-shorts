class NewsletterSubscribersController < ApplicationController
  def new
    @newsletter_subscriber = NewsletterSubscriber.new
  end

  def create
    @newsletter_subscriber = NewsletterSubscriber.new(newsletter_subscriber_params)

    if @newsletter_subscriber.save
        # @unsubscribe = Rails.application.message_verifier(:unsubscribe).generate(@user.id)
        #NewsletterMailer.new_subscriber_email(@newsletter_subscriber).deliver_later
    else
      render :new
    end
  end

  def unsubscribe
    @newsletter_subscriber = NewsletterSubscriber.find(params[:id])
  end

  def destroy
    @newsletter_subscriber = NewsletterSubscriber.find(params[:id])

    @newsletter_subscriber.destroy
      redirect_to root_path, notice: 'You have successfully unsubscribed from our newsletter.'
  end

  private
    def newsletter_subscriber_params
      params.require(:newsletter_subscriber).permit(:email)
    end
end
