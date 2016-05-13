FactoryGirl.define do
  factory :student do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    father_name { Faker::Name.first_name }
    mother_name { Faker::Name.first_name }
    birthdate { Faker::Date.between(18.years.ago, 6.years.ago) }
    association :school, factory: :active_school

    factory :invalid_student do
      first_name ''
    end
  end
end
