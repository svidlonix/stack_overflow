FactoryBot.define do
  factory :answer_comment do
    text { Faker::Lorem.sentence }
    answer
    association :commenter, factory: :user
  end
end
