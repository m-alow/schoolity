FactoryGirl.define do
  factory :studying do
    association :classroom
    association :student
    beginning_date  { Faker::Date.backward 100 }
    end_date "2016-05-07"

    before(:create) { |s| s.classroom.school.students << s.student }

    factory :invalid_studying do
      begining_date nil
    end
  end
end
