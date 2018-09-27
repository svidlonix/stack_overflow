require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :controller do
  describe 'GET #index' do
    let(:user) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: user.id) }
    let!(:question) { create(:question) }
    let!(:answer) { create(:answer, question: question) }
    let(:params) { { access_token: token } }

    before { get 'index', params: params, format: :json }

    it_should_behave_like 'api_unauthenticate'

    context 'when user send valid auth' do
      let(:token) { access_token.token }

      it { expect(response).to be_success }
      it { expect(JSON.parse(response.body).first['id']).to eq(question.id) }
      it { expect(JSON.parse(response.body).first['title']).to eq(question.title) }
      it { expect(JSON.parse(response.body).first['body']).to eq(question.body) }
      it { expect(JSON.parse(response.body).first['answers'].first['id']).to eq(answer.id) }
      it { expect(JSON.parse(response.body).first['answers'].first['body']).to eq(answer.body) }
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: user.id) }
    let!(:question) { create(:question) }
    let!(:answer) { create(:answer, question: question) }
    let!(:question_comment) { create(:question_comment, question: question) }
    let(:params) { { access_token: token, id: question.id } }

    before { get 'show', params: params, format: :json }

    it_should_behave_like 'api_unauthenticate'

    context 'when user send valid auth' do
      let(:token) { access_token.token }

      it { expect(response).to be_success }
      it { expect(JSON.parse(response.body)['id']).to eq(question.id) }
      it { expect(JSON.parse(response.body)['title']).to eq(question.title) }
      it { expect(JSON.parse(response.body)['body']).to eq(question.body) }
      it { expect(JSON.parse(response.body)['answers'].first['id']).to eq(answer.id) }
      it { expect(JSON.parse(response.body)['answers'].first['body']).to eq(answer.body) }
      it { expect(JSON.parse(response.body)['comments'].first['id']).to eq(question_comment.id) }
      it { expect(JSON.parse(response.body)['comments'].first['text']).to eq(question_comment.text) }
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: user.id) }
    let(:question_attributes) { attributes_for(:question).merge(owner_id: user.id) }
    let(:params) { { access_token: token, question: question_attributes } }

    subject { post 'create', params: params, format: :json }

    context 'when user send valid auth' do
      let(:token) { access_token.token }

      it { expect { subject }.to change(Question, :count).by(1) }
      it { expect { subject }.to change(SubscribeNotification, :count).by(1) }
      it 'check question params' do
        subject
        expect(Question.last.title).to eq(question_attributes[:title])
        expect(Question.last.body).to eq(question_attributes[:body])
        expect(Question.last.owner).to eq(user)
      end
    end
  end
end
