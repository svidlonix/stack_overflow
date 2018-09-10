FactoryBot.define do
  factory :question do
    title { Faker::Lorem.sentence }
    body { 'MyText' }
  end

  factory :invalid_question, class: 'Question' do
    title { nil }
    body { nil }
  end

  factory :new_question, class: 'Question' do
    title { Faker::Lorem.sentence }
    body { 'NewText' }
  end
end
