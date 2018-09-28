class DailyNotification < SmartInit::Base
  is_callable

  def call
    questions_created_today = Question.created_today

    User.visitors.each do |user|
      UserMailer.daily_notification(user, questions_created_today).deliver_now
    end
  end
end
