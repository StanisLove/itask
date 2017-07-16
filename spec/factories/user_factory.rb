FactoryGirl.define do
  sequence :email do |n|
    "email_#{Nenv.test_env_number || 1}_#{n}@itask.com"
  end

  factory :user do
    email
    name { Faker::Name.first_name }
    password 'qwerty'
    password_confirmation 'qwerty'
    email_verified true

    trait :admin do
      role 'admin'
    end

    factory :admin, traits: [:admin]
  end
end
