FactoryGirl.define do
  factory :school_class do
    association :school, factory: :active_school
    name { Faker::Name.name }

    factory :invalid_school_class do
      name nil
    end
  end
end
