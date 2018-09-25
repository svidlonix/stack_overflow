FactoryBot.define do
  factory :authorization do
    user
    provider { 'facebook' }
    nickname { Faker::FunnyName.name }
    uid { '123456789' }
  end

  factory :not_exists_authorization, class: 'Authorization' do
    user
    provider { 'twitter' }
    nickname { Faker::FunnyName.name }
    uid { '987654321' }
  end
end
