require 'features/feature_helper'

describe 'the sigup process', type: :feature do
  it 'signs with valid data' do
    visit new_user_registration_path
    fill_in 'Email', with: Faker::Internet.email
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(current_path).to eq root_path
  end

  it 'signs with invalid data' do
    visit new_user_registration_path
    fill_in 'Email', with: ''
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(current_path).to eq user_registration_path
  end
end
