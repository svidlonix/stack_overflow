require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  let(:owner) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'POST #crete' do
    before { sign_in(other_user) }

    subject do
      post :create,
           format: :js,
           params: {
             commit: commit,
             vote:   {
               vote_for_id: vote_for.id,
               voter_id:    other_user.id,
               type:        type
             }
           }
    end

    context 'when vote for question' do
      let!(:vote_for) { create(:question) }
      let(:type) { 'Question' }
      let(:commit) { 'Vote For' }

      it 'shod be created' do
        expect { subject }.to change(QuestionVote, :count).by(1)
        expect(QuestionVote.last.vote_for_id).to eq(vote_for.id)
        expect(QuestionVote.last.vote).to eq('vote_for')
      end
    end

    context 'when vote for answer' do
      let!(:vote_for) { create(:answer) }
      let(:type) { 'Answer' }
      let(:commit) { 'Vote For' }

      it 'shod be created' do
        expect { subject }.to change(AnswerVote, :count).by(1)
        expect(AnswerVote.last.vote_for_id).to eq(vote_for.id)
        expect(AnswerVote.last.vote).to eq('vote_for')
      end
    end

    context 'when owner question try vote against' do
      let!(:vote_for) { create(:question) }
      let(:type) { 'Question' }
      let(:commit) { 'Vote Against' }

      it 'shod be created' do
        expect { subject }.to change(QuestionVote, :count).by(1)
        expect(QuestionVote.last.vote_for_id).to eq(vote_for.id)
        expect(QuestionVote.last.vote).to eq('vote_against')
      end
    end

    context 'when owner answer try vote against' do
      let!(:vote_for) { create(:answer) }
      let(:type) { 'Answer' }
      let(:commit) { 'Vote Against' }

      it 'shod be created' do
        expect { subject }.to change(AnswerVote, :count).by(1)
        expect(AnswerVote.last.vote_for_id).to eq(vote_for.id)
        expect(AnswerVote.last.vote).to eq('vote_against')
      end
    end
  end

  describe 'GET #delete' do
    before { sign_in(user) }

    subject do
      delete :destroy,
             format: :js,
             params: {
               id:   vote.id,
               vote: {
                 vote_for_id: vote_for.id,
                 voter_id:    user.id,
                 type:        type
               }
             }
    end

    context 'owner can cancel vote for answer' do
      let!(:user) { owner }
      let!(:vote_for) { create(:answer) }
      let(:type) { 'Answer' }
      let(:vote) { create(:answer_vote, answer: vote_for, voter: owner) }

      before { vote.reload }

      it { expect { subject }.to change(AnswerVote, :count).by(-1) }
    end

    context 'wner can vote for question' do
      let!(:user) { owner }
      let!(:vote_for) { create(:question) }
      let(:vote) { create(:question_vote, question: vote_for, voter: owner) }
      let(:type) { 'Question' }

      before { vote.reload }

      it { expect { subject }.to change(QuestionVote, :count).by(-1) }
    end

    context 'other user cannot cancel vote for answer' do
      let!(:user) { other_user }
      let!(:vote_for) { create(:answer) }
      let(:type) { 'Answer' }
      let(:vote) { create(:answer_vote, answer: vote_for, voter: owner) }

      before { vote.reload }

      it { expect { subject }.not_to change(AnswerVote, :count) }
    end

    context 'other user cannot vote for question' do
      let!(:user) { other_user }
      let!(:vote_for) { create(:question) }
      let(:vote) { create(:question_vote, question: vote_for, voter: owner) }
      let(:type) { 'Question' }

      before { vote.reload }

      it { expect { subject }.not_to change(QuestionVote, :count) }
    end
  end
end
