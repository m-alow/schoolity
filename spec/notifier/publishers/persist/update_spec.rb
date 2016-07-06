require 'rails_helper'
require 'notifier/publishers/persist/update'

RSpec.describe Notifier::Publishers::Persist::Update do
  let(:subject) { Notifier::Publishers::Persist::Update.new }
  let(:user) { create :user }
  let(:scope) { double :scope, :call => [user], role: 'Role' }
  let(:notifiable) { create :classroom }

  context 'notification is present' do
    let!(:notification) { create :classroom_announcement_notification, recipient: user, recipient_role: 'Role', notifiable: notifiable }

    it 'does not create a new notification' do
      expect {
        subject.call scope, notifiable
      }.not_to change(Notification, :count)
    end

    it 'updates notification' do
      expect {
        subject.call scope, notifiable
        notification.reload
      }.to change(notification, :updated_at)
    end

    it 'makes the notification  unread' do
      subject.call scope, notifiable
      expect(notification.reload.read_at).to be_nil
    end
  end

  context 'notification is no present' do
    it 'creates a new notification' do
      expect {
        subject.call scope, notifiable
      }.to change(Notification, :count).by(1)
    end
  end
end
