require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe 'GET #show' do
    let(:answer) { create(:answer) }

    before { get :show, params: {id: answer.id} }

    it { expect(assigns(:answer)).to eq(answer) }
    it { expect(response).to render_template(:show) }
  end

  describe 'GET #new' do
    before { get :new }

    it { expect(assigns(:answer)).to be_a_new(Answer) }
    it { expect(response).to render_template(:new) }
  end

  describe 'GET #edit' do
    let(:answer) { create(:answer) }

    before { get :edit, params: {id: answer.id} }

    it { expect(assigns(:answer)).to eq(answer) }
    it { expect(response).to render_template(:edit) }
  end

  describe 'POST #create' do
    let(:question) { create(:question) }
    subject { post :create, params: {answer: answer_attributes}, format: :js }

    context 'when valid data' do
      let(:answer_attributes) { attributes_for(:answer).merge(question_id: question.id) }

      it { expect { subject }.to change(Answer, :count).by(1) }
      it { expect(subject).to render_template 'answers/create' }
    end

    context 'when invalid answers data' do
      let(:answer_attributes) { attributes_for(:invalid_answer).merge(question_id: question.id) }

      it { expect { subject }.not_to change(Answer, :count) }
      it { expect(subject).to render_template 'answers/create' }
    end
  end

  describe 'PATCH #update' do
    before do
      patch :update, params: {id: answer.id, answer: answer_attributes}
      answer.reload
    end

    context 'when valid data' do
      let(:answer) { create(:answer) }
      let(:answer_attributes) { attributes_for(:new_answer) }

      it { expect(subject).to redirect_to answer_path(assigns(:answer)) }
      it { expect(answer.body).to eq(attributes_for(:new_answer)[:body]) }
    end

    context 'when invalid answers data' do
      let(:answer) { create(:answer) }
      let(:answer_attributes) { attributes_for(:invalid_answer) }

      it { expect(subject).to render_template(:edit) }
      it { expect(answer.body).to eq(attributes_for(:answer)[:body]) }
    end
  end

  describe 'DELETE #destroy' do
    let(:answer) { create(:answer) }

    before { answer.reload }

    subject { delete :destroy, params: {id: answer} }

    it { expect { delete :destroy, params: {id: answer.id} }.to change(Answer, :count).by(-1) }
    it { expect(subject).to redirect_to answers_path }
  end
end
