require 'rails_helper'

RSpec.describe Notification, type: :model do
  it { should belong_to :notifiable }
  it { should belong_to :recipient }
  it { should belong_to :actor }

  it { should validate_presence_of :notifiable }
  it { should validate_presence_of :recipient }
  it { should validate_presence_of :actor }
  it { should validate_presence_of :recipient_role }
  it { should_not validate_presence_of :read_at }
end
