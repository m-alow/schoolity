FactoryGirl.define do
  factory :notification do
    association :recipient, factory: :user
    recipient_role 'Follower'
    read_at  { Faker::Time.backward }

    factory :classroom_announcement_notification do
      association :notifiable, factory: :classroom
    end
  end
end
