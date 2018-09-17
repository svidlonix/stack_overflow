require 'rails_helper'

RSpec.describe QuestionAttachment, type: :model do
  it { is_expected.to belong_to(:question) }
end
