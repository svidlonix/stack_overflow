FactoryBot.define do
  factory :answer_vote do
    vote { 0 }
    answer
    association :voter, factory: :user
  end
end
