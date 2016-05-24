require 'rails_helper'

RSpec.describe FollowingCodePolicy do
  subject { described_class }

  let(:school) { build(:active_school, owner: owner) }
  let(:another_school) { build(:active_school) }
  let(:student) { build(:student, school: school) }
  let(:another_student) { build(:student, school: another_school) }
  let(:following_code) { FollowingCode.make student }
  let(:another_following_code) { FollowingCode.make another_student }

  let(:admin) { build(:admin) }
  let(:owner) { build(:user) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:user) { build(:user) }

  permissions :index? do
    it 'allows admin' do
      expect(subject).to permit(admin, school)
    end

    it 'allows school owner' do
      expect(subject).to permit(owner, school)
    end

    it 'prevents school owner from accessing other schools' do
      expect(subject).not_to permit(owner, another_school)
    end

    it 'allows school administrator' do
      expect(subject).to permit(school_admin, school)
    end

    it 'prevents school administrator from accessing other schools' do
      expect(subject).not_to permit(school_admin, another_school)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, school)
    end
  end

  permissions :show?, :create?, :destroy? do
    it 'allows admin' do
      expect(subject).to permit(admin, following_code)
    end

    it 'allows school owner' do
      expect(subject).to permit(owner, following_code)
    end

    it 'prevents school owner from accessing other schools' do
      expect(subject).not_to permit(owner, another_following_code)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, following_code)
    end

    it 'prevents school admin form accessing other schools' do
      expect(subject).not_to permit(school_admin, another_following_code)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, following_code)
    end
  end
end
