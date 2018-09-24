require 'rails_helper'
require 'cancan/matchers'

describe Ability do
  let(:question) { create(:question, owner: owner) }
  let(:answer) { create(:answer, owner: owner) }
  let(:question_vote) { create(:question_vote, voter: owner) }
  let(:answer_vote) { create(:answer_vote, voter: owner) }
  let(:answer_comment) { create(:answer_comment, commenter: owner) }
  let(:question_comment) { create(:question_comment, commenter: owner) }

  subject(:ability) { Ability.new(user) }

  describe 'visitor' do
    context 'when not owner' do
      let(:owner) { create(:user) }
      let(:user) { create(:user) }

      it { is_expected.to be_able_to :read, :all }
      it { is_expected.to be_able_to :create, Question }
      it { is_expected.to be_able_to :create, Answer }
      it { is_expected.to be_able_to :create, question_vote }
      it { is_expected.to be_able_to :create, answer_vote }
      it { is_expected.to be_able_to :create, answer_comment }
      it { is_expected.to be_able_to :create, question_comment }

      it { is_expected.not_to be_able_to :update, question }
      it { is_expected.not_to be_able_to :update, answer }

      it { is_expected.not_to be_able_to :destroy, question }
      it { is_expected.not_to be_able_to :destroy, answer }
      it { is_expected.not_to be_able_to :destroy, question_vote }
      it { is_expected.not_to be_able_to :destroy, answer_vote }
      it { is_expected.not_to be_able_to :destroy, answer_comment }
      it { is_expected.not_to be_able_to :destroy, question_comment }
    end

    context 'when owner' do
      let(:owner) { create(:user) }
      let(:user) { owner }

      it { is_expected.to be_able_to :update, question }
      it { is_expected.to be_able_to :update, answer }

      it { is_expected.to be_able_to :destroy, question }
      it { is_expected.to be_able_to :destroy, answer }
      it { is_expected.to be_able_to :destroy, question_vote }
      it { is_expected.to be_able_to :destroy, answer_vote }
      it { is_expected.to be_able_to :destroy, answer_comment }
      it { is_expected.to be_able_to :destroy, question_comment }
    end
  end

  describe 'manager' do
    let(:owner) { create(:user) }
    let(:user) { create(:manager) }

    it { is_expected.not_to be_able_to :create, Question }
    it { is_expected.not_to be_able_to :create, Answer }
    it { is_expected.not_to be_able_to :create, QuestionVote }
    it { is_expected.not_to be_able_to :create, AnswerVote }
    it { is_expected.not_to be_able_to :create, AnswerComment }
    it { is_expected.not_to be_able_to :create, QuestionComment }

    it { is_expected.to be_able_to :update, question }
    it { is_expected.to be_able_to :update, answer }

    it { is_expected.to be_able_to :destroy, question }
    it { is_expected.to be_able_to :destroy, answer }
    it { is_expected.to be_able_to :destroy, answer_comment }
    it { is_expected.to be_able_to :destroy, question_comment }
    it { is_expected.not_to be_able_to :destroy, question_vote }
    it { is_expected.not_to be_able_to :destroy, answer_vote }
  end

  describe 'admin' do
    let(:user) { create(:admin) }
    let(:owner) { create(:user) }

    it { is_expected.to be_able_to :manage, Question }
    it { is_expected.to be_able_to :manage, Answer }
    it { is_expected.to be_able_to :manage, Comment }
    it { is_expected.not_to be_able_to :manage, Vote }
  end
end
