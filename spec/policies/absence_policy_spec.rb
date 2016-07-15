require 'rails_helper'

RSpec.describe AbsencePolicy do
  let(:absence) { create :absence, student: student, day: day }
  let(:day) { create :day }
  let(:classroom) { day.classroom }
  let(:school) { classroom.school }
  let(:student) { create(:studying, classroom: classroom).student }
  let(:another_day) { create :day }
  let(:another_absence) { create :absence, day: another_day }

  let(:owner) { school.owner }
  let(:admin) { create(:school_administration, administrated_school: school).administrator }
  let(:teacher) { create(:teaching, classroom: classroom, all_subjects: true).teacher }
  let(:parent){ create(:following, student: student).user }
  let(:user) { create :user }


  subject { described_class }

  permissions :index? do
    it 'allows owner' do
      expect(subject).to permit(owner, day)
    end

    it 'prevents owner from accessing other schools' do
      expect(subject).not_to permit(owner, another_day)
    end

    it 'allows admin' do
      expect(subject).to permit(admin, day)
    end

    it 'prevents admin from accessing other schools' do
      expect(subject).not_to permit(admin, another_day)
    end

    it 'prevents teacher' do
      expect(subject).not_to permit(teacher, day)
    end

    it 'prevents parent' do
      expect(subject).not_to permit(parent, day)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, day)
    end
  end

  permissions :update?, :destroy? do
    it 'allows owner' do
      expect(subject).to permit(owner, absence)
    end

    it 'prevents owner from accessing other schools' do
      expect(subject).not_to permit(owner, another_absence)
    end

    it 'allows admin' do
      expect(subject).to permit(admin, absence)
    end

    it 'prevents admin from accessing other schools' do
      expect(subject).not_to permit(admin, another_absence)
    end

    it 'prevents teacher' do
      expect(subject).not_to permit(teacher, absence)
    end

    it 'prevents parent' do
      expect(subject).not_to permit(parent, absence)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, absence)
    end
  end

  permissions :show? do
    it 'allows owner' do
      expect(subject).to permit(owner, absence)
    end

    it 'prevents owner from accessing other schools' do
      expect(subject).not_to permit(owner, another_absence)
    end

    it 'allows admin' do
      expect(subject).to permit(admin, absence)
    end

    it 'prevents admin from accessing other schools' do
      expect(subject).not_to permit(admin, another_absence)
    end

    it 'prevents teacher' do
      expect(subject).not_to permit(teacher, absence)
    end

    it 'allows parent' do
      expect(subject).to permit(parent, absence)
    end

    it 'prevents parent from accessing other students' do
      expect(subject).not_to permit(parent, another_absence)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, absence)
    end
  end
end
