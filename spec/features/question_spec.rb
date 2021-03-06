require 'features/feature_helper'

describe 'can work with quetion', type: :feature do
  let(:existing_user) { create(:admin) }
  let(:guest) { create(:user) }

  context 'when logged in user' do
    let!(:question1) { create(:question) }
    let!(:question2) { create(:question) }

    it 'see list of questions' do
      sign_in(existing_user)
      visit questions_path

      expect(page).to have_content question1.title
      expect(page).to have_content question2.title
      expect(current_path).to eq questions_path
    end

    it 'see question' do
      sign_in(existing_user)
      visit question_path(question1)

      expect(page).to have_content question1.title
      expect(page).to have_content question1.body
      expect(current_path).to eq question_path(question1)
    end

    it 'create questions' do
      title = Faker::Lorem.sentence
      body = Faker::Lorem.paragraph
      sign_in(existing_user)
      visit new_question_path

      fill_in 'Title', with: title
      fill_in 'Body', with: body
      click_button 'Create'

      expect(page).to have_content title
      expect(page).to have_content body
    end

    it 'cannot create questions with invalid data' do
      title = Faker::Lorem.sentence
      body = ''
      sign_in(existing_user)
      visit new_question_path

      fill_in 'Title', with: title
      fill_in 'Body', with: body
      click_button 'Create'
      expect(find_field('Title').value).to eq(title)
      expect(find_field('Body').value).to eq(body)
    end

    it 'can attach file when create question', js: true do
      title = Faker::Lorem.sentence
      body = Faker::Lorem.paragraph
      sign_in(existing_user)
      visit new_question_path

      fill_in 'Title', with: title
      fill_in 'Body', with: body
      attach_file 'File', "#{Rails.root}/spec/first_test_file.txt"
      click_button 'Create Question'

      expect(page).to have_content('first_test_file.txt')
    end

    it 'can attach file when edit question', js: true do
      sign_in(existing_user)
      visit(edit_question_path(question1))

      click_link('Add new attachment field')
      attach_file 'File', "#{Rails.root}/spec/first_test_file.txt"
      click_button 'Update'

      expect(page).to have_content('first_test_file.txt')
    end

    it 'can remove file when edit question', js: true do
      title = Faker::Lorem.sentence
      body = Faker::Lorem.paragraph
      sign_in(existing_user)

      visit(new_question_path)

      fill_in 'Title', with: title
      fill_in 'Body', with: body
      attach_file 'File', "#{Rails.root}/spec/first_test_file.txt"
      click_button 'Create'

      visit(edit_question_path(Question.last))
      click_link('Remove this attachment')
      click_button 'Update'

      expect(page).not_to have_content('first_test_file.txt')
    end

    it 'show question in runtime', js: true do
      title = Faker::Lorem.sentence

      Capybara.using_session('existing_user') do
        sign_in(existing_user)
        visit(questions_path)
      end

      Capybara.using_session('guest') do
        sign_in(existing_user)
        visit(questions_path)
      end

      Capybara.using_session('existing_user') do
        body = Faker::Lorem.paragraph
        visit(new_question_path)

        fill_in('Title', with: title)
        fill_in('Body', with: body)
        click_button('Create')

        expect(page).to have_content(title)
        expect(page).to have_content(body)
      end

      Capybara.using_session('guest') do
        expect(page).to have_content(title)
      end
    end
  end

  context 'when not logged in user' do
    let(:not_existing_user) { build(:user) }

    it 'cannot see list of questions' do
      sign_in(not_existing_user)
      visit questions_path

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
      expect(current_path).to eq new_user_session_path
    end

    it 'cannot create questions' do
      sign_in(not_existing_user)
      visit new_question_path

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
      expect(current_path).to eq new_user_session_path
    end
  end
end
