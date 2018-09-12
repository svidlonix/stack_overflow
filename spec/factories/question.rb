FactoryBot.define do
  factory :question do
    association :owner, factory: :user
    title { Faker::Lorem.sentence }
    body { 'MyText' }
  end

  factory :invalid_question, class: 'Question' do
    association :owner, factory: :user
    title { nil }
    body { nil }
  end

  factory :new_question, class: 'Question' do
    association :owner, factory: :user
    title { Faker::Lorem.sentence }
    body { 'NewText' }
  end
end
