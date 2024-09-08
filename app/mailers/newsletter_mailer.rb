class NewsletterMailer < ApplicationMailer
  def new_subscriber_email(newsletter_subscriber)
    @newsletter_subscriber = newsletter_subscriber # Instance variable => available in view
    mail(to: newsletter_subscriber.email, subject: 'Thank you for Subscribing!')
  end
end
