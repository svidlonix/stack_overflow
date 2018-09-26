require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:admin) }

  before { sign_in(user) }

  describe 'POST #create' do
    let(:question) { create(:question) }
    subject { post :create, params: { answer: answer_attributes }, format: :js }

    it_should_behave_like 'create_answer', 'answer', 1
    it_should_behave_like 'create_answer', 'invalid_answer', 0
  end

  describe 'PATCH #update' do
    let(:question) { create(:question) }
    let(:answer) { create(:answer, question: question) }

    before do
      patch :update, params: { id: answer.id, answer: answer_attributes, format: :js }
      answer.reload
    end

    context 'when valid data' do
      let(:answer_attributes) { attributes_for(:new_answer) }

      it { expect(subject).to render_template('answers/update') }
      it { expect(answer.body).to eq(answer_attributes[:body]) }
    end

    context 'when invalid answers data' do
      let(:answer_attributes) { attributes_for(:invalid_answer) }

      it { expect(subject).to render_template('answers/update') }
      it { expect(answer.body).to eq(answer.body) }
    end
  end

  describe 'DELETE #destroy' do
    let(:answer) { create(:answer) }

    before { answer.reload }

    subject { delete :destroy, params: { id: answer } }

    it { expect { delete :destroy, params: { id: answer.id } }.to change(Answer, :count).by(-1) }
    it { expect(subject).to redirect_to answers_path }
  end
end
