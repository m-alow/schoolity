FactoryGirl.define do
  factory :school do
    name { Faker::Company.name }
    association :owner, factory: :user
    factory :invalid_school do
      name nil
    end

    factory :active_school do
      active true
    end

    factory :non_active_school do
      active false
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
