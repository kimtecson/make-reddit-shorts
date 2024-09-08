class FeedbackMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.feedback_mailer.send_feedback.subject
  #
  def send_feedback(sender, subject, message)
    @message = message
    @sender = sender
    mail(
      to: 'makeredditshorts@gmail.com', # Change to the actual recipient's email
      subject: subject,
      from: sender
    )
  end
end
