require 'rails_helper'

RSpec.describe CreatedAnswerNotification do
  describe '#call' do
    let(:question) { create(:question) }
    let(:subscribe_notification1) { create(:subscribe_notification, question_id: question.id) }
    let(:subscribe_notification2) { create(:subscribe_notification, question_id: question.id) }

    it 'should send  new answer notification' do
      UserMailer.should_receive(:created_answer_notification).and_call_original
      CreatedAnswerNotification.call(question: question)
    end
  end
end
