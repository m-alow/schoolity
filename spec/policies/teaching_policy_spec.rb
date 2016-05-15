require 'rails_helper'

RSpec.describe TeachingPolicy do
  let(:school) { build(:active_school, owner: owner) }
  let(:school_class) { build(:school_class, school: school) }
  let(:classroom) { build(:classroom, school_class: school_class) }
  let(:another_classroom) { build(:classroom, school_class: create(:school_class)) }
  let(:teaching) { build(:teaching, classroom: classroom) }
  let(:another_teaching) { build(:teaching, classroom: another_classroom) }

  let(:admin) { build(:admin) }
  let(:owner) { build(:user) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:teacher) { create(:teaching, classroom: classroom).teacher }
  let(:user) { build(:user) }

  subject { described_class }

  permissions :index? do
    it 'allows admin' do
      expect(subject).to permit(admin, classroom)
    end

    it 'allows school owner' do
      expect(subject).to permit(owner, classroom)
    end

    it 'prevents school owner from accessing other schools' do
      expect(subject).not_to permit(owner, another_classroom)
    end

    it 'allows school administrator' do
      expect(subject).to permit(school_admin, classroom)
    end

    it 'prevents school administrator from accessing other schools' do
      expect(subject).not_to permit(school_admin, another_classroom)
    end

    it 'prevents teacher' do
      expect(subject).not_to permit(teacher, classroom)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, classroom)
    end
  end

  permissions :show?, :new?, :create?, :edit?, :update?, :destroy? do
    it 'allows admin' do
      expect(subject).to permit(admin, teaching)
    end

    it 'allows school owner' do
      expect(subject).to permit(owner, teaching)
    end

    it 'prevents school owner from accessing other schools' do
      expect(subject).not_to permit(owner, another_teaching)
    end

    it 'allows school administrator' do
      expect(subject).to permit(school_admin, teaching)
    end

    it 'prevents school administrator from accessing other schools' do
      expect(subject).not_to permit(school_admin, another_teaching)
    end

    it 'prevents teacher' do
      expect(subject).not_to permit(teacher, teaching)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, teaching)
    end
  end
end
