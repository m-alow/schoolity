FactoryGirl.define do
  factory :school do
    name { Faker::Company.name }

    factory :invalid_school do
      name nil
    end

    factory :school_with_classes do
      transient do
        school_classes_count 3
      end

      after(:create) do |school, evaluater|
        create_list(:schooL_class, evaluater.school_classes_count, school: school)
      end
    end
  end
end
