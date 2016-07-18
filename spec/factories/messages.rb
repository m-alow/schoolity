FactoryGirl.define do
  factory :message do
    user nil
    student nil
    message_type "MyString"
    content_type "MyString"
    content "MyText"
  end
end
