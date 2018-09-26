require 'rails_helper'

RSpec.describe Api::V1::AnswersController, type: :controller do
  describe 'GET #index' do
    let(:user) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: user.id) }
    let!(:question) { create(:question) }
    let!(:answer1) { create(:answer, question: question) }
    let!(:answer2) { create(:answer, question: question) }
    let(:params) { { access_token: token, question_id: question.id } }

    before { get 'index', params: params, format: :json }

    it_should_behave_like 'api_unauthenticate'

    context 'when user send valid auth' do
      let(:token) { access_token.token }

      it { expect(response).to be_success }
      it { expect(JSON.parse(response.body).first['id']).to eq(answer1.id) }
      it { expect(JSON.parse(response.body).first['body']).to eq(answer1.body) }
      it { expect(JSON.parse(response.body).first['question_id']).to eq(question.id) }
      it { expect(JSON.parse(response.body).second['id']).to eq(answer2.id) }
      it { expect(JSON.parse(response.body).second['body']).to eq(answer2.body) }
      it { expect(JSON.parse(response.body).second['question_id']).to eq(question.id) }
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: user.id) }
    let!(:question) { create(:question) }
    let!(:answer) { create(:answer, question: question) }
    let!(:answer_comment) { create(:answer_comment, answer: answer) }
    let(:params) { { access_token: token, id: answer.id, question_id: question.id } }

    before { get 'show', params: params, format: :json }

    it_should_behave_like 'api_unauthenticate'

    context 'when user send valid auth' do
      let(:token) { access_token.token }

      it { expect(response).to be_success }
      it { expect(JSON.parse(response.body)['id']).to eq(answer.id) }
      it { expect(JSON.parse(response.body)['body']).to eq(answer.body) }
      it { expect(JSON.parse(response.body)['comments'].first['id']).to eq(answer_comment.id) }
      it { expect(JSON.parse(response.body)['comments'].first['text']).to eq(answer_comment.text) }
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: user.id) }
    let!(:question) { create(:question) }
    let(:params) { { access_token: token, answer: answer_attributes, question_id: question.id } }
    let(:answer_attributes) do
      attributes_for(:answer).merge(question_id: question.id, owner_id: user.id)
    end

    subject { post 'create', params: params, format: :json }

    context 'when user send valid auth' do
      let(:token) { access_token.token }

      it { expect { subject }.to change(Answer, :count).by(1) }
      it 'check params created answer' do
        subject
        expect(Answer.last.body).to eq(answer_attributes[:body])
        expect(Answer.last.owner_id).to eq(answer_attributes[:owner_id])
        expect(Answer.last.question_id).to eq(answer_attributes[:question_id])
      end
    end
  end
end
