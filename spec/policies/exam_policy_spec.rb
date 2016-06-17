require 'rails_helper'

RSpec.describe ExamPolicy do
  let(:classroom) { create :classroom }
  let(:student) { create(:studying, classroom: classroom).student }
  let(:math) { create :subject, school_class: classroom.school_class }
  let(:exam) { create :exam, classroom: classroom, subject: math }
  let(:another_classroom) { create :classroom }
  let(:another_exam) { create :exam }

  let(:owner) { classroom.school.owner }
  let(:school_admin) { create(:school_administration, administrated_school: classroom.school).administrator }
  let(:teacher) { create(:teaching, classroom: classroom, subject: math).teacher }
  let(:parent) { create(:following, student: student).user }
  let(:user) { create :user }

  subject { described_class }

  permissions :index? do
    it 'allows school owner' do
      expect(subject).to permit(owner, classroom)
    end

    it 'prevents school owner from accessing other schools' do
      expect(subject).not_to permit(owner, another_classroom)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, classroom)
    end

    it 'prevents school admin from accessing other schools' do
      expect(subject).not_to permit(school_admin, another_classroom)
    end

    it 'allows teacher' do
      expect(subject).to permit(teacher, classroom)
    end

    it 'prevents teacher from accessing classrooms he is not teaching' do
      expect(subject).not_to permit(teacher, another_classroom)
    end

    it 'prevents parent' do
      expect(subject).not_to permit(parent, classroom)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, classroom)
    end
  end

  permissions :show? do
    it 'allows school owner' do
      expect(subject).to permit(owner, exam)
    end

    it 'prevents school owner from accessing other schools' do
      expect(subject).not_to permit(owner, another_exam)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, exam)
    end

    it 'prevents school admin from accessing other schools' do
      expect(subject).not_to permit(school_admin, another_exam)
    end

    it 'allows teacher' do
      expect(subject).to permit(teacher, exam)
    end

    it 'prevents teacher from accessing classrooms he is not teaching' do
      exam.classroom = create(:classroom, school_class: classroom.school_class)
      expect(subject).not_to permit(teacher, exam)
    end

    it 'prevents teacher from accessing subjects he is not teaching' do
      exam.subject = create(:subject, school_class: classroom.school_class)
      expect(subject).not_to permit(teacher, exam)
    end

    it 'allows parent' do
      expect(subject).to permit(parent, exam)
    end

    it 'prevents parent from accessing students he is not following' do
      expect(subject).not_to permit(parent, another_exam)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, exam)
    end
  end

  permissions :create?, :edit?, :update?, :destroy? do
    it 'prevents school owner' do
      expect(subject).not_to permit(owner, exam)
    end

    it 'prevents school admin' do
      expect(subject).not_to permit(school_admin, exam)
    end

    it 'allows teacher' do
      expect(subject).to permit(teacher, exam)
    end

    it 'prevents teacher from accessing classrooms he is not teaching' do
      exam.classroom = create(:classroom, school_class: classroom.school_class)
      expect(subject).not_to permit(teacher, exam)
    end

    it 'prevents teacher from accessing subjects he  is not teaching' do
      exam.subject = create(:subject, school_class: classroom.school_class)
      expect(subject).not_to permit(teacher, exam)
    end

    it 'prevents parent' do
      expect(subject).not_to permit(parent, exam)
    end

    it 'prevents user' do
      expect(subject).not_to permit(user, exam)
    end
  end

    permissions :new? do
    it 'prevents school owner' do
      expect(subject).not_to permit(owner, exam)
    end

    it 'prevents school admin' do
      expect(subject).not_to permit(school_admin, exam)
    end

    it 'allows teacher' do
      expect(subject).to permit(teacher, exam)
    end

    it 'prevents teacher from accessing classrooms he is not teaching' do
      exam.classroom = create(:classroom, school_class: classroom.school_class)
      expect(subject).not_to permit(teacher, exam)
    end

    it 'prevents parent' do
      expect(subject).not_to permit(parent, exam)
    end

    it 'prevents user' do
      expect(subject).not_to permit(user, exam)
    end
  end
end
