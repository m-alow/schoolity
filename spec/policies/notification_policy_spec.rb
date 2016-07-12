require 'rails_helper'

RSpec.describe NotificationPolicy do
  let(:notification) { create :grade_notification, notifiable: create(:grade) }

  subject { described_class }

  permissions :show? do
    it 'allows recipient user' do
      expect(subject).to permit(notification.recipient, notification)
    end

    it 'prevents other users' do
      user = create :user
      expect(subject).not_to permit(user, notification)
    end
  end
end
