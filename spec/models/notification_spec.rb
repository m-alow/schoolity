require 'rails_helper'

RSpec.describe Notification, type: :model do
  it { should belong_to :notifiable }
  it { should belong_to :recipient }

  it { should validate_presence_of :notifiable }
  it { should validate_presence_of :recipient }
  it { should validate_presence_of :recipient_role }
  it { should_not validate_presence_of :read_at }

  describe '#read?' do
    it 'is true if read_at is not nil' do
      n = build :notification, read_at: Time.zone.now
      expect(n.read?).to be true
    end

    it 'is false if read_at is nil' do
      n = build :notification, read_at: nil
      expect(n.read?).to be false
    end
  end
end
