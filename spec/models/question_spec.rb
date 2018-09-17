require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { create(:question) }

  describe 'associations' do
    it { is_expected.to belong_to(:owner) }

    it { is_expected.to have_many(:answers) }
    it { is_expected.to have_many(:attachments) }
    it { is_expected.to have_many(:votes) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :body }
  end

  describe '#vote_for' do
    before { 3.times { create(:question_vote, question: question, vote: 1) } }

    it { expect(question.vote_for).to eq(3) }
  end

  describe '#vote_against' do
    before { 4.times { create(:question_vote, question: question, vote: 0) } }

    it { expect(question.vote_against).to eq(4) }
  end
end
