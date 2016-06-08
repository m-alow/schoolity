FactoryGirl.define do
  factory :timetable do
    association :classroom
    active true
    weekends ['Friday']
    periods_number  4
  end
end
