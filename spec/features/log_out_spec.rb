require 'features/feature_helper'

describe 'the lofout process', type: :feature do
  let(:existing_user) { create(:user) }

  it 'signs with exist user' do
    sign_in(existing_user)
    click_link 'Logout'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq destroy_user_session_path
  end
end
