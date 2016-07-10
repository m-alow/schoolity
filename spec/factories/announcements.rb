FactoryGirl.define do
  factory :announcement do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.sentence }
    association :author, factory: :user

    factory :school_announcement do
      association :announceable, factory: :school
    end

    factory :school_class_announcement do
      association :announceable, factory: :school_class
    end

    factory :classroom_announcement do
      association :announceable, factory: :classroom
    end

    factory :student_announcement do
      association :announceable, factory: :student
    end
  end
end
