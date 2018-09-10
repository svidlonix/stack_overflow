require 'rails_helper'

RSpec.describe AnswerController, type: :controller do
  describe 'GET #index' do
    let(:answers) { create_list(:answer, 2) }

    before { get :index }

    it { expect(assigns(:answers)).to match_array(answers) }
    it { expect(response).to render_template(:index) }
  end

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
    subject { post :create, params: {answer: answer_attributes} }

    context 'when valid data' do
      let(:question) { create(:question) }
      let(:answer_attributes) { attributes_for(:answer).merge(question_id: question.id) }

      it { expect { subject }.to change(Answer, :count).by(1) }
      it { expect(subject).to redirect_to answer_path(assigns(:answer)) }
    end

    context 'when invalid question data' do
      let(:answer_attributes) { attributes_for(:invalid_answer) }

      it { expect { subject }.not_to change(Answer, :count) }
      it { expect(subject).to render_template(:new) }
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

    context 'when invalid question data' do
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
    it { expect(subject).to redirect_to answer_path }
  end
end
