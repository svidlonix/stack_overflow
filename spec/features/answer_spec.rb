require 'features/feature_helper'

describe 'the signin process', type: :feature do
  let(:existing_user) { create(:user) }
  let(:guest) { create(:user) }
  let(:existing_other_user) { create(:user) }
  context 'when logged in user' do
    let!(:question) { create(:question, owner: existing_user) }
    let!(:answer) { create(:answer, question: question, owner: existing_user) }

    it 'can create answer', js: true do
      body = Faker::Lorem.paragraph
      sign_in(existing_user)
      visit(question_path(question))

      within '#new_answer' do
        fill_in('Body', with: body)
        click_button('Create')
      end

      within '.answers' do
        expect(page).to have_content(body)
      end
      expect(current_path).to eq(question_path(question))
    end

    it 'can see answers' do
      sign_in(existing_user)
      visit(answer_path(answer))

      expect(page).to have_content(answer.body)
      expect(current_path).to eq(answer_path(answer))
    end

    it 'cannot create answer with invalid data', js: true do
      body = ''
      sign_in(existing_user)
      visit(question_path(question))

      fill_in('Body', with: body)
      click_button('Create Answer')

      within '.answers' do
        expect(page).to have_content(body)
      end
      expect(page).to have_content("Body can't be blank")
      expect(current_path).to eq(question_path(question))
    end

    it 'owner can update answer', js: true do
      body = Faker::Lorem.paragraph
      sign_in(existing_user)
      visit(question_path(question))

      within '.answers' do
        click_link('Edit')

        fill_in('Body', with: body)
        click_button('Save')
        expect(page).to have_content(body)
        expect(current_path).to eq(question_path(question))
      end
    end

    it 'other user cannot update answer', js: true do
      sign_in(existing_other_user)
      visit(question_path(question))

      within '.answers' do
        expect(page).not_to have_content('Edit')
      end
    end

    it 'cannot update answer with invalid data', js: true do
      body = ''
      sign_in(existing_user)
      visit(question_path(question))

      within '.answers' do
        click_link('Edit')

        fill_in('Body', with: body)
        click_button('Save')

        expect(page).to have_content(body)
        expect(current_path).to eq(question_path(question))
      end

      expect(page).to have_content("Body can't be blank")
    end

    it 'can attach file when create answer', js: true do
      body = Faker::Lorem.paragraph
      sign_in(existing_user)
      visit(question_path(question))

      fill_in('Body', with: body)
      attach_file 'File', "#{Rails.root}/spec/first_test_file.txt"
      click_button('Create Answer')

      expect(page).to have_content('first_test_file.txt')
      expect(current_path).to eq(question_path(question))
    end

    it 'can attach file when edit question', js: true do
      sign_in(existing_user)
      visit(question_path(question))

      within '.answers' do
        click_link('Edit')

        click_link('Add new attachment field')
        attach_file 'File', "#{Rails.root}/spec/first_test_file.txt"

        click_button('Save')
      end
      expect(page).to have_content('first_test_file.txt')
      expect(current_path).to eq(question_path(question))
    end

    it 'show answer in runtime', js: true do
      body = Faker::Lorem.paragraph

      Capybara.using_session('existing_user') do
        sign_in(existing_user)
        visit(question_path(question))
      end

      Capybara.using_session('guest') do
        sign_in(existing_user)
        visit(question_path(question))
      end

      Capybara.using_session('existing_user') do
        within '#new_answer' do
          fill_in('Body', with: body)
          click_button('Create Answer')
        end

        within '.answers' do
          expect(page).to have_content(body)
        end
      end

      Capybara.using_session('guest') do
        within '.answers' do
          expect(page).to have_content(body)
        end
      end
    end
  end
end
