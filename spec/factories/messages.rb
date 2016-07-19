FactoryGirl.define do
  factory :message do
    association :user
    association :student
    message_type "suggestion"
    content_type "base"
    content { {} }
  end
end
