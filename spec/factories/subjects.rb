FactoryGirl.define do
  factory :subject do
    name { Faker::Name.name }
    association :school_class

    factory :invalid_subject do
      name ''
    end
  end
end
