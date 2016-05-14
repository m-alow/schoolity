require 'rails_helper'

RSpec.describe SubjectPolicy do
  let(:school) { build(:active_school, owner: owner) }
  let(:other_school) { build(:active_school) }
  let(:school_class) { build(:school_class, school: school) }
  let(:other_school_class) { build(:school_class, school: other_school) }
  let(:a_subject) { build(:subject, school_class: school_class) }
  let(:other_subject) { build(:subject, school_class: other_school_class) }

  let(:admin) { build(:admin) }
  let(:owner) { build(:user) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:user) { build(:user) }

  subject { described_class }

  permissions :index? do
    it 'allows admin' do
      expect(subject).to permit(admin, school_class)
    end

    it 'allows school owner' do
      expect(subject).to permit(owner, school_class)
    end

    it 'prevents school owner from accessing other schools' do
      expect(subject).not_to permit(owner, other_school_class)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, school_class)
    end

    it 'prevents school admin from acessing other schools' do
      expect(subject).not_to permit(school_admin, other_school_class)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, school_class)
    end
  end

  permissions :show?, :new?, :create?, :edit?, :update?, :destroy? do
    it 'allows admin' do
      expect(subject).to permit(admin, a_subject)
    end

    it 'allows school owner' do
      expect(subject).to permit(owner, a_subject)
    end

    it 'prevents school owner from accessing other schools' do
      expect(subject).not_to permit(owner, other_subject)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, a_subject)
    end

    it 'prevents school admin from acessing other schools' do
      expect(subject).not_to permit(school_admin, other_subject)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, a_subject)
    end
  end
end
