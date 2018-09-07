require 'rails_helper'

RSpec.describe QuestionController, type: :controller do
  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it { expect(assigns(:questions)).to match_array(questions) }
    it { expect(response).to render_template(:index) }
  end

  describe 'GET #show' do
    let(:question) { create(:question) }

    before { get :show, params: {id: question.id} }

    it { expect(assigns(:question)).to eq(question) }
    it { expect(response).to render_template(:show) }
  end

  describe 'GET #new' do
    before { get :new }

    it { expect(assigns(:question)).to be_a_new(Question) }
    it { expect(response).to render_template(:new) }
  end

  describe 'GET #edit' do
    let(:question) { create(:question) }

    before { get :edit, params: {id: question.id} }

    it { expect(assigns(:question)).to eq(question) }
    it { expect(response).to render_template(:edit) }
  end

  describe 'GET #edit' do
    let(:question) { create(:question) }

    before { get :edit, params: {id: question.id} }

    it { expect(assigns(:question)).to eq(question) }
    it { expect(response).to render_template(:edit) }
  end

  describe 'POST #create' do
    subject { post :create, params: {question: question_attributes} }

    context 'when valid data' do
      let(:question_attributes) { attributes_for(:question) }

      it { expect { subject }.to change(Question, :count).by(1) }
      it { expect(subject).to redirect_to question_path(assigns(:question)) }
    end

    context 'when invalid question data' do
      let(:question_attributes) { attributes_for(:invalid_question) }

      it { expect { subject }.not_to change(Question, :count) }
      it { expect(subject).to render_template(:new) }
    end
  end

  describe 'PATCH #update' do
    before do
      patch :update, params: {id: question, question: question_attributes}
      question.reload
    end

    context 'when valid data' do
      let(:question) { create(:question) }
      let(:question_attributes) { attributes_for(:new_question) }

      it { expect(subject).to redirect_to question_path(assigns(:question)) }
      it { expect(question.title).to eq(attributes_for(:new_question)[:title]) }
      it { expect(question.body).to eq(attributes_for(:new_question)[:body]) }
    end

    context 'when invalid question data' do
      let(:question) { create(:question) }
      let(:question_attributes) { attributes_for(:invalid_question) }

      it { expect(subject).to render_template(:edit) }
      it { expect(question.title).to eq(attributes_for(:question)[:title]) }
      it { expect(question.body).to eq(attributes_for(:question)[:body]) }
    end
  end

  describe 'DELETE #destroy' do
    let(:question) { create(:question) }

    before { question.reload }

    subject { delete :destroy, params: {id: question} }

    it { expect { subject }.to change(Question, :count).by(-1) }
    it { expect(subject).to redirect_to question_path }
  end
end
