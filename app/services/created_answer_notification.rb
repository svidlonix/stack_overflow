class CreatedAnswerNotification < SmartInit::Base
  initialize_with_keywords :question
  is_callable

  def call
    question.subscribe_notifications.each do |subscribe_notification|
      UserMailer.created_answer_notification(subscribe_notification.user, question).deliver_later
    end
  end
  end
