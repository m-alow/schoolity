FactoryGirl.define do
  factory :classroom do
    school_class
    name { Faker::Name.name }

    factory :invalid_classroom do
      name nil
    end
  end
end
