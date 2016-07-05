require 'rails_helper'

RSpec.describe GradePolicy do
  let(:grade) { build :grade }
  let(:classroom) { grade.exam.classroom }
  let(:school) { classroom.school }
  let(:another_grade) { build :grade }

  let(:owner) { school.owner }
  let(:admin) { create(:school_administration, administrated_school: school).administrator }
  let(:teacher) { create(:teaching, classroom: classroom, subject: grade.exam.subject).teacher }
  let(:parent) { create(:following, student: grade.student).user }

  subject { described_class }

  permissions :show? do
    it 'allows school owner' do
      expect(subject).to permit(owner, grade)
    end

    it 'prevents school owner from accessing grades in other schools' do
      expect(subject).not_to permit(owner, another_grade)
    end

    it 'allows school admin' do
      expect(subject).to permit(admin, grade)
    end

    it 'prevents school admin from accessing grades in other schools' do
      expect(subject).not_to permit(admin, another_grade)
    end

    it 'allows teacher' do
      expect(subject).to permit(teacher, grade)
    end

    it 'prevents teacher from accessing grades of students he is not teaching' do
      expect(subject).not_to permit(teacher, another_grade)
    end

    it 'allows parent' do
      expect(subject).to permit(parent, grade)
    end

    it 'prevents parent from accessing grades of students he is not following' do
      expect(subject).not_to permit(parent, another_grade)
    end


    it 'prevents other users' do
      expect(subject).not_to permit(create(:user), grade)
    end
  end
end
