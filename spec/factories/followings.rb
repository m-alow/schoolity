FactoryGirl.define do
  factory :following do
    association :user
    association :student
    relationship { %w(Father Mother Uncle).sample }
  end
end
