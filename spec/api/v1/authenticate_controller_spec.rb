require 'rails_helper'

RSpec.describe Api::V1::AuthenticateController, type: :controller do
  describe 'GET /profile' do
    before { get 'profile', params: params, format: :json }

    context 'when user do not authenticate' do
      let(:params) { {} }

      it { expect(response.status).to eq(401) }
    end

    context 'when user send not valid auth' do
      let(:params) { { access_token: 'invalid' } }

      it { expect(response.status).to eq(401) }
    end

    context 'when user send valid auth' do
      let(:user) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: user.id) }
      let(:params) { { access_token: access_token.token } }

      it { expect(response).to be_success }
      it { expect(JSON.parse(response.body)['email']).to eq(user.email) }
      it { expect(JSON.parse(response.body)['id']).to eq(user.id) }
    end
  end

  describe 'GET /application_profiles' do
    let!(:oauth_application) { create(:oauth_application) }
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }
    let(:user4) { create(:user) }
    let(:access_token1) { create(:access_token, resource_owner_id: user1.id, application: oauth_application) }
    let(:users) { [user4.attributes, user3.attributes, user2.attributes] }

    before do
      create(:access_token, resource_owner_id: user2.id, application: oauth_application)
      create(:access_token, resource_owner_id: user3.id, application: oauth_application)
      create(:access_token, resource_owner_id: user4.id, application: oauth_application)
      get 'application_profiles', params: { access_token: access_token1.token }, format: :json
    end

    it { expect(response).to be_success }
    it { expect(JSON.parse(response.body).first['email']).to eq(user2.email) }
    it { expect(JSON.parse(response.body).first['id']).to eq(user2.id) }
    it { expect(JSON.parse(response.body).second['email']).to eq(user3.email) }
    it { expect(JSON.parse(response.body).second['id']).to eq(user3.id) }
    it { expect(JSON.parse(response.body).third['email']).to eq(user4.email) }
    it { expect(JSON.parse(response.body).third['id']).to eq(user4.id) }
  end
end
