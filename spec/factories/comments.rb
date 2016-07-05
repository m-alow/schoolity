FactoryGirl.define do
  factory :comment do
    commentable nil
    association :user
    body "Comment"
    role "Parent"
  end
end
