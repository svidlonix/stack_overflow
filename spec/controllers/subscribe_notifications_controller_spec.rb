require 'rails_helper'

RSpec.describe SubscribeNotificationsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:question) { create(:question) }

  before { sign_in(user) }

  describe 'POST #crete' do
    subject do
      post :create,
           format: :js,
           params: {
             subscribe_notification: {
               question_id: question.id,
               user_id:     user.id
             }
           }
    end

    it 'should be created' do
      expect { subject }.to change(SubscribeNotification, :count).by(1)
      expect(SubscribeNotification.last.question).to eq(question)
      expect(SubscribeNotification.last.user).to eq(user)
    end
  end

  describe 'GET #delete' do
    let(:subscribe_notification) { create(:subscribe_notification, question_id: question.id, user_id: user.id) }

    subject do
      delete :destroy,
             format: :js,
             params: {
               id:                     subscribe_notification.id,
               subscribe_notification: {
                 question_id: question.id,
                 user_id:     user.id
               }
             }
    end

    before { subscribe_notification.reload }

    it { expect { subject }.to change(SubscribeNotification, :count).by(-1) }
  end
end
