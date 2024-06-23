FactoryBot.define do
  factory :user do
    email { "#{Faker::Internet.unique.user_name}@domain.com" }
    password { 'password' }
    role { :customer }
  end
end
