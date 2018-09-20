FactoryBot.define do
  factory :question_comment do
    text { Faker::Lorem.sentence }
    question
    association :commenter, factory: :user
  end
end
