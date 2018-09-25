FactoryBot.define do
  factory :oauth_application, class: 'Doorkeeper::Application' do
    name { Faker::FunnyName.name }
    uid { '12345678' }
    redirect_uri { 'urn:ietf:wg:oauth:2.0:oob' }
    secret { '87654321' }
  end
end
