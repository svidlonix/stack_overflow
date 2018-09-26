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

    it_should_behave_like 'create_vote', :question, 'Question', 'QuestionVote', 'Vote For'
    it_should_behave_like 'create_vote', :answer, 'Answer', 'AnswerVote', 'Vote For'
    it_should_behave_like 'create_vote', :question, 'Question', 'QuestionVote', 'Vote Against'
    it_should_behave_like 'create_vote', :answer, 'Answer', 'AnswerVote', 'Vote Against'
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

    it_should_behave_like 'delete_vote', :answer, 'Answer', 'AnswerVote'
    it_should_behave_like 'delete_vote', :question, 'Question', 'QuestionVote'
    it_should_behave_like 'camnnot_delete_vote', :question, 'Question', 'QuestionVote'
    it_should_behave_like 'camnnot_delete_vote', :answer, 'Answer', 'AnswerVote'
  end
end
