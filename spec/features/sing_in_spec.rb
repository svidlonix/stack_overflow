require 'features/feature_helper'

describe 'the signin process', type: :feature do
  let(:existing_user) { create(:user) }
  let(:not_existing_user) { build(:user) }

  it 'signs with exist user' do
    sign_in(existing_user)

    expect(page).to have_content 'Signed in successfully'
    expect(current_path).to eq root_path
  end

  it 'signs with not exist user' do
    sign_in(not_existing_user)

    expect(page).to have_content 'Invalid Email or password.'
    expect(current_path).to eq new_user_session_path
  end
end
