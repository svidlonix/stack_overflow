require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:question) }
    it { is_expected.to belong_to(:owner) }

    it { is_expected.to have_many(:attachments) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :body }
  end
end
