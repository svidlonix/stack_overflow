require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:owner) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'POST #crete' do
    before { sign_in(other_user) }

    subject do
      post :create,
           format: :js,
           params: {
             comment: {
               comment_on_id: comment_on.id,
               commenter_id:  other_user.id,
               text:          text,
               type:          type
             }
           }
    end

    it_should_behave_like 'create_comment', :question, 'Question', 'QuestionComment'
    it_should_behave_like 'create_comment', :answer, 'Answer', 'AnswerComment'
  end
end
