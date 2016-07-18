require 'rails_helper'

RSpec.describe Message, type: :model do
  it { should belong_to :user }
  it { should belong_to :student }

  it { should validate_presence_of :user }
  it { should validate_presence_of :student }
  it { should validate_presence_of :content }
  it { should validate_presence_of :message_type }
  it { should_not validate_presence_of :content_type }
end
