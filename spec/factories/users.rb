FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :admin, class: 'User' do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    admin { true }
  end

  factory :manager, class: 'User' do
    email { Faker::Internet.email }
    password { 'password' }
    manager { true }
  end

  factory :not_exists_user, class: 'User' do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
