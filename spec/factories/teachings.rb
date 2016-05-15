FactoryGirl.define do
  factory :teaching do
    association :teacher, factory: :user
    association :classroom
    association :subject
    all_subjects false

    factory :invalid_teaching do
      classroom nil
    end
  end
end
