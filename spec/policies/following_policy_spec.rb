require 'rails_helper'

RSpec.describe FollowingPolicy do
  subject { described_class }

  let(:school) { build(:active_school) }
  let(:student) { build(:student, school: school) }
  let(:parent) { build(:user) }
  let(:user) { build(:user) }
  let(:following) { create(:following, user: parent, student: student) }
  let(:another_following) { create(:following) }

  permissions :index?, :new?, :create? do
    it 'allows user' do
      expect(subject).to permit(user)
    end
  end

  permissions :show?, :destroy? do
    it 'allows parent' do
      expect(subject).to permit(parent, following)
    end

    it 'prevents another follower of the same student' do
      create(:following, user: user, student: student)
      expect(subject).not_to permit(user, following)
    end

    it 'prevents parent from accessing other students' do
      expect(subject).not_to permit(parent, another_following)
    end
  end
end
