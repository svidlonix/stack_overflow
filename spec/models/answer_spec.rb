require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:answer) { create(:answer) }

  describe 'associations' do
    it { is_expected.to belong_to(:question) }
    it { is_expected.to belong_to(:owner) }

    it { is_expected.to have_many(:attachments) }
    it { is_expected.to have_many(:votes) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :body }
  end

  describe '#vote_for' do
    before { 3.times { create(:answer_vote, answer: answer, vote: 1) } }

    it { expect(answer.vote_for).to eq(3) }
  end

  describe '#vote_against' do
    before { 4.times { create(:answer_vote, answer: answer, vote: 0) } }

    it { expect(answer.vote_against).to eq(4) }
  end
end
