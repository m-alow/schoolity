require 'rails_helper'

RSpec.describe MessagePolicy do
  let(:message) { create(:message) }
  let(:another_message) { create(:message) }
  let(:student) { message.student }
  let(:school) { message.student.school }

  let(:parent) { message.user }

  let(:owner) { school.owner }
  let(:admin) { create(:school_administration, administrated_school: school).administrator }
  let(:user) { create :user }

  subject { described_class }

  permissions :show? do
    it 'allows owner' do
      expect(subject).to permit(owner, message)
    end

    it 'prevents owner form accessing other students' do
      expect(subject).not_to permit(owner, another_message)
    end

    it 'allows admin' do
      expect(subject).to permit(admin, message)
    end

    it 'prevents admin form accessing other students' do
      expect(subject).not_to permit(admin, another_message)
    end

    it 'allows parent' do
      create(:following, user: parent, student: student)
      expect(subject).to permit(parent, message)
    end

    it 'prevents parent if he is not following the student anymore' do
      expect(subject).not_to permit(parent, message)
    end

    it 'prevents parent if he is not the message author' do
      create(:following, user: parent, student: student)
      message.user = create(:user)
      expect(subject).not_to permit(parent, message)
    end

    it 'prevents parent form accessing other students' do
      create(:following, user: parent, student: student)
      expect(subject).not_to permit(parent, another_message)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, message)
    end
  end
end
