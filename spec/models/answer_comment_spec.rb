require 'rails_helper'

RSpec.describe AnswerComment, type: :model do
  it { is_expected.to belong_to(:answer) }
  it { is_expected.to belong_to(:commenter) }

  describe 'validations' do
    it { is_expected.to validate_presence_of :text }
  end
end
