FactoryGirl.define do
  factory :grade do
    association :exam
    association :student
    score 1
  end
end
