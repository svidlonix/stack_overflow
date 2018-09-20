require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:answers) }
    it { is_expected.to have_many(:questions) }
    it { is_expected.to have_many(:answer_comments) }
    it { is_expected.to have_many(:question_comments) }
  end
end
