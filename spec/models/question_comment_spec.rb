require 'rails_helper'

RSpec.describe QuestionComment, type: :model do
  it { is_expected.to belong_to(:question) }
  it { is_expected.to belong_to(:commenter) }

  describe 'validations' do
    it { is_expected.to validate_presence_of :text }
  end
end
