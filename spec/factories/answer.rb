FactoryBot.define do
  factory :answer do
    association :owner, factory: :user
    question
    body { 'MyText' }
  end

  factory :invalid_answer, class: 'Answer' do
    association :owner, factory: :user
    question
    body { nil }
  end

  factory :new_answer, class: 'Answer' do
    association :owner, factory: :user
    question
    body { 'NewText' }
  end
end
