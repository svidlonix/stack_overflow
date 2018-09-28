require 'rails_helper'

RSpec.describe DailyNotification do
  describe '#call' do
    let!(:question) { create(:question) }
    let!(:user1) { create(:user) }
    let!(:user1) { create(:user) }

    it 'should send new answer notification' do
      UserMailer.should_receive(:daily_notification).twice.and_call_original
      DailyNotification.call
    end
  end
end
