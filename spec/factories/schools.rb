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
  end
end
