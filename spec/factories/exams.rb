FactoryGirl.define do
  factory :exam do
    association :classroom
    association :subject
    score 30
    minimum_score 15
    date "2016-06-17"
    description "MyText"
  end
end
