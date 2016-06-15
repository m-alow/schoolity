FactoryGirl.define do
  factory :lesson do
    association :day
    association :subject
    order { Faker::Number.rand_in_range 1, 5 }
    content_type "base"
    content { {} }
  end
end
