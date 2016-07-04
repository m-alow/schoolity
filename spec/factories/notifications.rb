FactoryGirl.define do
  factory :notification do
    association :recipient, factory: :user
    recipient_role 'Follower'
    read_at  { Faker::Time.backward }

    factory :school_announcement_notification do
      association :notifiable, factory: :school
    end

    factory :school_class_announcement_notification do
      association :notifiable, factory: :school_class
    end

    factory :classroom_announcement_notification do
      association :notifiable, factory: :classroom
    end

    factory :grade_notification do
      association :notifiable, factory: :grade
    end
  end
end
