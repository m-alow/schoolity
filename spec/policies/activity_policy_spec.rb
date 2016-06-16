require 'rails_helper'

RSpec.describe ActivityPolicy do
  let(:classroom) { build(:classroom) }
  let(:a_subject) { build(:subject, school_class: classroom.school_class) }
  let(:student) { create(:studying, classroom: classroom).student }
  let(:lesson) { build(:lesson, day: build(:day, classroom: classroom), subject: a_subject) }
  let(:another_lesson) { build(:lesson) }

  let(:activity) { build(:activity, lesson: lesson, student: student) }

  let(:owner) { classroom.school.owner }
  let(:school_admin) { create(:school_administration, administrated_school: classroom.school).administrator }
  let(:teacher) { create(:teaching, classroom: classroom, subject: a_subject).teacher }
  let(:user) { build(:user) }

  subject { described_class }

  permissions :update? do
    it 'prevents school owner' do
      expect(subject).not_to permit(owner, activity)
    end

    it 'prevents school admin' do
      expect(subject).not_to permit(school_admin, activity)
    end

    it 'allows teacher' do
      expect(subject).to permit(teacher, activity)
    end

    it 'prevents teacher from updating activities for students he is not teaching' do
      another_student = create(:studying, classroom: classroom).student
      another_lesson = create(:lesson, day: create(:day, classroom: classroom))
      another_activity = create(:activity, student: another_student, lesson: another_lesson)
      expect(subject).not_to permit(teacher, another_activity)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, activity)
    end
  end

  permissions :index? do
    it 'allows school owner' do
      expect(subject).to permit(owner, lesson)
    end

    it 'prevents school owner form accessing lessons in other schools' do
      expect(subject).not_to permit(owner, another_lesson)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, lesson)
    end

    it 'prevents school admin from accessing lessons in other schools' do
      expect(subject).not_to permit(school_admin, another_lesson)
    end

    it 'allows teacher' do
      expect(subject).to permit(teacher, lesson)
    end

    it 'prevents teacher from accessing activities for students he is not teaching' do
      another_lesson = create(:lesson, day: create(:day, classroom: classroom))
      expect(subject).not_to permit(teacher, another_lesson)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, lesson)
    end
  end

  permissions :edit? do
    it 'prevents school owner' do
      expect(subject).not_to permit(owner, lesson)
    end

    it 'prevents school admin' do
      expect(subject).not_to permit(school_admin, lesson)
    end

    it 'allows teacher' do
      expect(subject).to permit(teacher, lesson)
    end

    it 'prevents teacher from accessing activities for students he is not teaching' do
      another_lesson = create(:lesson, day: create(:day, classroom: classroom))
      expect(subject).not_to permit(teacher, another_lesson)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, lesson)
    end
  end
end
