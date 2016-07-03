FactoryGirl.define do
  factory :notification do
    association :recipient, factory: :user
    association :actor, factory: :user
    recipient_role 'Parent'
    read_at  { Faker::Time.backward }
  end
end
