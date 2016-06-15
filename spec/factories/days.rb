FactoryGirl.define do
  factory :day do
    association :classroom
    date { Faker::Date.backward 100 }
    content_type "base"
    content { {} }
  end
end
