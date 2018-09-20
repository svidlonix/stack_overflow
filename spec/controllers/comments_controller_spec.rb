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

    context 'when comment on question' do
      let!(:comment_on) { create(:question) }
      let(:text) { Faker::Lorem.sentence }
      let(:type) { 'Question' }

      it 'shod be created' do
        expect { subject }.to change(QuestionComment, :count).by(1)
        expect(QuestionComment.last.comment_on_id).to eq(comment_on.id)
        expect(QuestionComment.last.text).to eq(text)
      end
    end

    context 'when comment on answer' do
      let!(:comment_on) { create(:answer) }
      let(:text) { Faker::Lorem.sentence }
      let(:type) { 'Answer' }

      it 'shod be created' do
        expect { subject }.to change(AnswerComment, :count).by(1)
        expect(AnswerComment.last.comment_on_id).to eq(comment_on.id)
        expect(AnswerComment.last.text).to eq(text)
      end
    end
  end

  describe 'GET #delete' do
    before { sign_in(other_user) }

    subject do
      delete :destroy,
             format: :js,
             params: {
               id:      comment.id,
               comment: {
                 comment_on_id: comment_on.id,
                 commenter_id:  other_user.id,
                 type:          type
               }
             }
    end

    context 'when cancel vote for answer' do
      let!(:comment_on) { create(:answer) }
      let(:type) { 'Answer' }
      let(:comment) { create(:answer_comment, answer: comment_on) }

      before { comment.reload }

      it { expect { subject }.to change(AnswerComment, :count).by(-1) }
    end

    context 'when cancel vote for question' do
      let!(:comment_on) { create(:question) }
      let(:comment) { create(:question_comment, question: comment_on) }
      let(:type) { 'Question' }

      before { comment.reload }

      it { expect { subject }.to change(QuestionComment, :count).by(-1) }
    end
  end
end
