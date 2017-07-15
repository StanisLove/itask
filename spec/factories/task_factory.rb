FactoryGirl.define do
  factory :task do
    name { Faker::Job.field }
    state 'new'
    user

    trait :started do
      state 'started'
    end

    trait :finished do
      state 'finished'
    end
  end
end
