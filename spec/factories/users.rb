FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    factory :invalid_user do
      email nil
    end

    factory :admin do
      admin true
    end
  end
end
