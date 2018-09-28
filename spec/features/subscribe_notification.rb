require 'features/feature_helper'

describe 'can work with subscribe notification', type: :feature do
  let(:user) { create(:user) }
  let!(:question) { create(:question, owner: user) }

  before do
    sign_in(user)
    visit(question_path(question))
  end

  it 'can subscribe to question', js: true do
    within '.subscribe_notification' do
      click_button('Subscribe Notifications')
    end

    within '.subscribe_notification' do
      expect(page).to have_selector(:link_or_button, 'Unsubscribe Notifications')
    end
  end

  it 'can subscribe to question', js: true do
    SubscribeNotification.create(user_id: user, question_id: question)

    within '.subscribe_notification' do
      click_button('Unsubscribe Notifications')
    end

    within '.subscribe_notification' do
      expect(page).to have_selector(:link_or_button, 'Subscribe Notifications')
    end
  end
end
