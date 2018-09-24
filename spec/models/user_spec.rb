require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:answers) }
    it { is_expected.to have_many(:questions) }
    it { is_expected.to have_many(:answer_comments) }
    it { is_expected.to have_many(:question_comments) }
    it { is_expected.to have_many(:authorizations) }
  end

  describe '.find_or_create_for_auth' do
    let!(:user) { create(:user) }
    let!(:authorization) { create(:authorization, user: user) }

    subject { User.find_or_create_for_auth(auth) }

    context 'when user and authorization exist' do
      let(:auth) do
        OmniAuth::AuthHash.new(
          provider: authorization.provider,
          uid:      authorization.uid,
          info:     { email: user.email }
        )
      end

      it { expect { subject }.not_to change(User, :count) }
      it { expect { subject }.not_to change(Authorization, :count) }
    end

    context 'when user and authorization exist' do
      let(:not_exists_authorization) { attributes_for(:not_exists_authorization, user: user) }
      let(:auth) do
        OmniAuth::AuthHash.new(
          provider: not_exists_authorization[:provider],
          uid:      not_exists_authorization[:uid],
          info:     { email: user.email }
        )
      end

      it { expect { subject }.not_to change(User, :count) }
      it { expect { subject }.to change(Authorization, :count) }
      it 'authorization should have correct data' do
        subject
        expect(Authorization.last.uid).to eq(not_exists_authorization[:uid])
        expect(Authorization.last.provider).to eq(not_exists_authorization[:provider])
      end
    end

    context 'when user and authorization exist' do
      let(:not_exists_authorization) { attributes_for(:not_exists_authorization) }
      let(:auth) do
        OmniAuth::AuthHash.new(
          provider: not_exists_authorization[:provider],
          uid:      not_exists_authorization[:uid],
          info:     { email: 'user@email.com' }
        )
      end

      it { expect { subject }.to change(User, :count) }
      it { expect { subject }.to change(Authorization, :count) }
      it 'authorization and user should have correct data' do
        subject
        expect(Authorization.last.uid).to eq(not_exists_authorization[:uid])
        expect(Authorization.last.provider).to eq(not_exists_authorization[:provider])
        expect(User.last.email).to eq('user@email.com')
      end
    end
  end
end
