FactoryGirl.define do
  factory :comment do
    commentable nil
    user nil
    body "MyText"
    role "MyString"
  end
end
