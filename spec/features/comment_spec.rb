require 'features/feature_helper'

describe 'can work with comment', type: :feature do
  let(:existing_user) { create(:user) }
  let(:guest) { create(:user) }

  let!(:question) { create(:question, owner: existing_user) }
  let!(:answer) { create(:answer, question: question, owner: existing_user) }

  it 'can create question comment', js: true do
    text = Faker::Lorem.paragraph
    sign_in(existing_user)
    visit(question_path(question))

    within '.question-comments' do
      fill_in('Text', with: text)
      click_button('Create Comment')
    end

    within '.question-comments' do
      within '.list-comments' do
        expect(page).to have_content(text)
      end
    end

    expect(current_path).to eq(question_path(question))
  end

  it 'can create answer comment', js: true do
    text = Faker::Lorem.paragraph
    sign_in(existing_user)
    visit(question_path(question))

    within ".answer-comments-#{answer.id}" do
      fill_in('Text', with: text)
      click_button('Create Comment')
    end

    within ".answer-comments-#{answer.id}" do
      expect(page).to have_content(text)
    end

    expect(current_path).to eq(question_path(question))
  end

  it 'show comment on question in runtime', js: true do
    text = Faker::Lorem.paragraph

    Capybara.using_session('existing_user') do
      sign_in(existing_user)
      visit(question_path(question))
    end

    Capybara.using_session('guest') do
      sign_in(existing_user)
      visit(question_path(question))
    end

    Capybara.using_session('existing_user') do
      within '.question-comments' do
        fill_in('Text', with: text)
        click_button('Create Comment')
      end

      within '.question-comments' do
        expect(page).to have_content(text)
      end
    end

    Capybara.using_session('guest') do
      within '.question-comments' do
        expect(page).to have_content(text)
      end
    end
  end

  it 'show comment on answer in runtime', js: true do
    text = Faker::Lorem.paragraph

    Capybara.using_session('existing_user') do
      sign_in(existing_user)
      visit(question_path(question))
    end

    Capybara.using_session('guest') do
      sign_in(existing_user)
      visit(question_path(question))
    end

    Capybara.using_session('existing_user') do
      within '.answers' do
        fill_in('Text', with: text)
        click_button('Create Comment')
      end

      within '.answers' do
        within '.list-comments' do
          expect(page).to have_content(text)
        end
      end
    end

    Capybara.using_session('guest') do
      within '.answers' do
        within '.list-comments' do
          expect(page).to have_content(text)
        end
      end
    end
  end
end
