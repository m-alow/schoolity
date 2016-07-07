require 'rails_helper'

RSpec.describe LessonPolicy do
  let(:lesson) { build(:lesson) }
  let(:another_lesson) { build(:lesson) }
  let(:classroom) { lesson.day.classroom }
  let(:student) { create(:studying, classroom: classroom).student }

  let(:teacher) { create(:teaching, classroom: classroom, subject: lesson.subject).teacher }
  let(:owner) { classroom.school.owner }
  let(:school_admin) { create(:school_administration, administrated_school: classroom.school).administrator }
  let(:parent) { create(:following, student: student).user }
  let(:user) { build(:user) }

  subject { described_class }

  permissions :update?, :update_qualified? do
    it 'prevents school owner' do
      expect(subject).not_to permit(owner, lesson)
    end

    it 'prevents school admin' do
      expect(subject).not_to permit(school_admin, lesson)
    end

    it 'allows teacher' do
      expect(subject).to permit(teacher, lesson)
    end

    it 'prevents teacher from accessing lessons he is not teaching' do
      expect(subject).not_to permit(teacher, another_lesson)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, lesson)
    end
  end

  permissions :show? do
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
      expect(subject).not_to permit(teacher, another_lesson)
    end

    it 'allows parent' do
      expect(subject).to permit(parent, lesson)
    end

    it 'prevents parent from accessing activities of students he is not following' do
      expect(subject).not_to permit(parent, another_lesson)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, lesson)
    end
  end
end
