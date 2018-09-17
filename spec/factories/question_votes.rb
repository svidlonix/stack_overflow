FactoryBot.define do
  factory :question_vote do
    vote { 0 }
    question
    association :voter, factory: :user
  end
end
