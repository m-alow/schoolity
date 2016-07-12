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

  describe '#mark_read!' do
    let(:notification) { create(:grade_notification, read_at: nil, notifiable: create(:grade)) }

    it 'sets read_at to the current time' do
      Timecop.freeze do
        notification.mark_read!
        expect(notification.read_at).to eq Time.zone.now
      end
    end

    it 'does not change updated_at' do
      expect {
        notification.mark_read!
      }.not_to change(notification, :updated_at)
    end
  end

  describe '#mark_unread!' do
    let(:notification) { create(:grade_notification, read_at: '2010-10-10'.to_date, notifiable: create(:grade)) }

    it 'sets read_at to nil' do
      notification.mark_unread!
      expect(notification.read_at).to be_nil
    end

    it 'does not change updated_at' do
      expect {
        notification.mark_unread!
      }.not_to change(notification, :updated_at)
    end
  end
end
