FactoryGirl.define do
  factory :absence do
    association :student
    association :day
    notes "MyText"
  end
end
