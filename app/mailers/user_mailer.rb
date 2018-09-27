class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  layout 'mailer'

  def daily_notification(user, objects)
    @user = user
    @objects = objects

    mail(to: @user.email, subject: 'Daily Notification')
  end

  def created_answer_notification(user, object)
    @user = user
    @object = object

    mail(to: @user.email, subject: 'New Answer Added')
  end
end
