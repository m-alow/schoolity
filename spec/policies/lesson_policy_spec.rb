require 'rails_helper'

RSpec.describe LessonPolicy do
  let(:lesson) { build(:lesson) }
  let(:another_lesson) { build(:lesson) }
  let(:classroom) { lesson.day.classroom }

  let(:teacher) { create(:teaching, classroom: classroom, subject: lesson.subject).teacher }
  let(:owner) { classroom.school.owner }
  let(:school_admin) { create(:school_administration, administrated_school: classroom.school).administrator }
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
end
