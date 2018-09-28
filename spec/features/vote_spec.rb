require 'features/feature_helper'

describe 'can work with vote', type: :feature do
  let(:existing_user) { create(:user) }
  let(:owner_user) { create(:user) }

  context 'when create vote' do
    let!(:question) { create(:question, owner: owner_user) }
    let!(:answer) { create(:answer, question: question, owner: owner_user) }

    it 'can vote for answer', js: true do
      sign_in(existing_user)
      visit(question_path(question))

      within ".answer-vote-#{answer.id}" do
        click_button('Vote For')
      end

      within '.vote-answer-for' do
        expect(page).to have_content(1)
      end
    end

    it 'can vote for question', js: true do
      sign_in(existing_user)
      visit(question_path(question))

      within '.question-vote' do
        click_button('Vote For')
      end

      within '.vote-question-for' do
        expect(page).to have_content(1)
      end
    end

    it 'can vote against answer', js: true do
      sign_in(existing_user)
      visit(question_path(question))

      within ".answer-vote-#{answer.id}" do
        click_button('Vote Against')
      end

      within '.vote-answer-against' do
        expect(page).to have_content(1)
      end
    end

    it 'can vote against question', js: true do
      sign_in(existing_user)
      visit(question_path(question))

      within '.question-vote' do
        click_button('Vote Against')
      end

      within '.vote-question-against' do
        expect(page).to have_content(1)
      end
    end

    it 'owner cannot vote answer', js: true do
      sign_in(owner_user)
      visit(question_path(question))

      within ".answer-vote-#{answer.id}" do
        expect(page).not_to have_content('Vote For')
        expect(page).not_to have_content('Vote Against')
      end
    end

    it 'owner cannot vote question', js: true do
      sign_in(owner_user)
      visit(question_path(question))

      within '.question-vote' do
        expect(page).not_to have_content('Vote For')
        expect(page).not_to have_content('Vote Against')
      end
    end
  end

  context 'when delete vote' do
    let!(:question) { create(:question, owner: owner_user) }
    let!(:question_vote) { create(:question_vote, question: question, voter: existing_user) }
    let!(:answer) { create(:answer, question: question, owner: owner_user) }
    let!(:answer_vote) { create(:answer_vote, answer: answer, voter: existing_user) }
    let(:other_user) { create(:user) }

    it 'owner can delete vote answer', js: true do
      sign_in(existing_user)
      visit(question_path(question))

      within ".answer-vote-#{answer.id}" do
        click_button('Delete Vote')
      end

      within '.vote-answer-against' do
        expect(page).to have_content(0)
      end
    end

    it 'owner can delete vote question', js: true do
      sign_in(existing_user)
      visit(question_path(question))

      within '.question-vote' do
        click_button('Delete Vote')
      end
    end

    it 'not owner can delete vote answer', js: true do
      sign_in(other_user)
      visit(question_path(question))

      within ".answer-vote-#{answer.id}" do
        expect(page).not_to have_content('Delete Vote')
      end
    end

    it 'not owner delete vote question', js: true do
      sign_in(other_user)
      visit(question_path(question))

      within '.question-vote' do
        expect(page).not_to have_content('Delete Vote')
      end
    end
  end
end
