require 'rails_helper'

RSpec.describe ClassroomPolicy do
  subject { described_class }

  let(:school) { create(:active_school, owner: school_owner) }
  let(:other_school) { create(:active_school) }
  let(:school_owner) { create(:user) }
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:classroom) { create(:classroom, school_class: create(:school_class, school: school)) }
  let(:other_classroom) { create(:classroom) }

  permissions :index? do
    it 'allows admin' do
      expect(subject).to permit(admin, school)
    end

    it 'allows school owner' do
      expect(subject).to permit(school_owner, school)
    end

    it 'prevents school owner from accessing classroom in other schools' do
      expect(subject).not_to permit(school_owner, other_school)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, school)
    end

    it 'prevents school admin from accessing classroom in other schools' do
      expect(subject).not_to permit(school_admin, other_school)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, school)
    end
  end

  permissions :show?, :new?, :create?, :edit?, :update?, :destroy? do
    it 'allows admin' do
      expect(subject).to permit(admin, classroom)
    end

    it 'allows school owner' do
      expect(subject).to permit(school_owner, classroom)
    end

    it 'prevents school owner from accessing classroom in other schools' do
      expect(subject).not_to permit(school_owner, other_classroom)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, classroom)
    end

    it 'prevents school admin from accessing classroom in other schools' do
      expect(subject).not_to permit(school_admin, other_classroom)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, classroom)
    end
  end
end
