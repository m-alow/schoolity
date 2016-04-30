FactoryGirl.define do
  factory :school_administration do
    association :administrator, factory: :user
    association :administrated_school, factory: :school
  end
end
