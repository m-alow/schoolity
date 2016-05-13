require 'rails_helper'

RSpec.describe StudyingPolicy do
  let(:school) { create(:active_school, owner: owner) }
  let(:student) { create(:student, school: school) }
  let(:school_class) { create(:school_class, school: school) }
  let(:studying) { create(:studying, student: student, classroom: create(:classroom, school_class: school_class)) }
  let(:admin) { create(:admin) }
  let(:owner) { create(:user) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:user) { create(:user) }
  let(:other_school) { create(:active_school) }
  let(:other_school_class) {create(:school_class, school: other_school) }
  let(:other_student) { create(:student) }
  let(:other_studying) { create(:studying, student: other_student, classroom: create(:classroom, school_class: other_school_class)) }

  subject { described_class }

  permissions :index? do
    it 'allows admin' do
      expect(subject).to permit(admin, school)
    end

    it 'allows school owner' do
      expect(subject).to permit(owner, school)
    end

    it 'prevents school owner from accessing studyings in other schools' do
      expect(subject).not_to permit(owner, other_school)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, school)
    end

    it 'prevents school admin form accessing studyings in other schools' do
      expect(subject).not_to permit(school_admin, other_school)
    end

    it 'prevents teacher' do
      pending
      expect(subject).not_to permit(teacher, school)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, school)
    end

  end

  permissions :show?, :new?, :create?, :edit?, :update?, :destroy? do
    it 'allows admin' do
      expect(subject).to permit(admin, studying)
    end

    it 'allows school owner' do
      expect(subject).to permit(owner, studying)
    end

    it 'prevents school owner from accessing students in other schools' do
      expect(subject).not_to permit(owner, other_studying)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, studying)
    end

    it 'prevents school admin form accessing students in other schools' do
      expect(subject).not_to permit(school_admin, other_studying)
    end

    it 'prevents teacher' do
      pending
      expect(subject).not_to permit(teacher, studying)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, studying)
    end
  end
end
