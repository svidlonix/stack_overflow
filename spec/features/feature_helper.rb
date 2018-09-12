require 'rails_helper'

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.after(:each) do
    DatabaseCleaner.clean_with(:truncation)
  end
end
