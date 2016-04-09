FactoryGirl.define do
  factory :school do
    name { Faker::Company.name }

    factory :invalid_school do
      name nil
    end
  end
end
