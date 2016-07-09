FactoryGirl.define do
  factory :behavior do
    association :student
    behaviorable nil
    content_type "base"
    content { "{}" }
  end
end
