FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :not_exists_user, class: 'User' do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
