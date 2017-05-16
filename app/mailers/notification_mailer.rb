class NotificationMailer < ApplicationMailer
  default from: 'test@gmail.com'
  default to: 'test2@gmail.com'

  def mailer(message)
    @text = message
    mail(subject: 'New Discounts :)')
  end
end
