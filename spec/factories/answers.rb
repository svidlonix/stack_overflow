FactoryBot.define do
  factory :answer do
    question
    body 'MyText'
  end

  factory :invalid_answer, class: 'Answer' do
    question
    body nil
  end

  factory :new_answer, class: 'Answer' do
    question
    body 'NewText'
  end
end
