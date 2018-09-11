require 'rails_helper'

describe 'the signin process', type: :feature do
  let(:existing_user) { create(:user) }

  context 'when logged in user' do
    let!(:question) { create(:question) }
    let!(:answer) { create(:answer) }

    it 'create answer' do
      body = Faker::Lorem.paragraph
      sign_in(existing_user)
      visit question_path(question)

      fill_in 'Body', with: body
      click_button 'Create'

      expect(page).to have_content body
      expect(current_path).to eq questions_path
    end

    it 'see answer' do
      sign_in(existing_user)
      visit answer_path(answer)

      expect(page).to have_content answer.body
      expect(current_path).to eq answer_path(answer)
    end

    it 'cannot create answer with invalid data' do
      body = ''
      sign_in(existing_user)
      visit question_path(question)

      fill_in 'Body', with: body
      click_button 'Create'

      expect(current_path).to eq question_path(question)
    end
  end
end
