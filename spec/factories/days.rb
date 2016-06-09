FactoryGirl.define do
  factory :day do
    association :classroom
    date { Faker::Date.backward 100 }
    content_type "hash_only"
    content ""
  end
end
