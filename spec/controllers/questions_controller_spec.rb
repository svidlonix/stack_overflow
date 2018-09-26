require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:admin) }

  before { sign_in(user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it { expect(assigns(:questions)).to match_array(questions) }
    it { expect(response).to render_template(:index) }
  end

  describe 'GET #show' do
    it_should_behave_like 'show_question', :show
  end

  describe 'GET #new' do
    before { get :new }

    it { expect(assigns(:question)).to be_a_new(Question) }
    it { expect(response).to render_template(:new) }
  end

  describe 'GET #edit' do
    it_should_behave_like 'show_question', :edit
  end

  describe 'POST #create' do
    subject { post :create, params: { question: question_attributes } }

    context 'when valid data' do
      let(:question_attributes) { attributes_for(:question).merge(owner_id: user.id) }

      it { expect { subject }.to change(Question, :count).by(1) }
      it { expect(subject).to redirect_to question_path(assigns(:question)) }
    end

    context 'when invalid questions data' do
      let(:question_attributes) { attributes_for(:invalid_question) }

      it { expect { subject }.not_to change(Question, :count) }
      it { expect(subject).to render_template(:new) }
    end
  end

  describe 'PATCH #update' do
    before do
      patch :update, params: { id: question, question: question_attributes }
      question.reload
    end

    context 'when valid data' do
      let(:question) { create(:question) }
      let(:question_attributes) { attributes_for(:new_question) }

      it { expect(subject).to redirect_to question_path(assigns(:question)) }
      it { expect(question.title).to eq(question_attributes[:title]) }
      it { expect(question.body).to eq(question_attributes[:body]) }
    end

    context 'when invalid questions data' do
      let(:question) { create(:question) }
      let(:question_attributes) { attributes_for(:invalid_question) }

      it { expect(subject).to render_template(:edit) }
    end
  end

  describe 'DELETE #destroy' do
    let(:question) { create(:question) }

    before { question.reload }

    subject { delete :destroy, params: { id: question.id } }

    it { expect { subject }.to change(Question, :count).by(-1) }
    it { expect(subject).to redirect_to questions_path }
  end
end
