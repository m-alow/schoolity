FactoryGirl.define do
  factory :activity do
    association :student
    association :lesson
    content_type "basic"
    content { { title: 'lesson', summary: 'sum' } }
  end
end
