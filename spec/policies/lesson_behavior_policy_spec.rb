require 'rails_helper'

RSpec.describe LessonBehaviorPolicy do
  let(:behavior) { create :behavior, student: student, behaviorable: lesson }
  let(:lesson) { create :lesson }
  let(:classroom) { lesson.day.classroom }
  let(:school) { classroom.school }
  let(:student) { create(:studying, classroom: classroom).student }
  let(:another_lesson) { create :lesson }
  let(:another_behavior) { create :behavior, behaviorable: another_lesson }

  let(:owner) { school.owner }
  let(:admin) { create(:school_administration, administrated_school: school).administrator }
  let(:teacher) { create(:teaching, classroom: classroom, all_subjects: true).teacher }
  let(:parent){ create(:following, student: student).user }
  let(:user) { create :user }

  subject { described_class }

  permissions :show? do
    it 'allows owner' do
      expect(subject).to permit(owner, behavior)
    end

    it 'prevents owner from accessing other schools' do
      expect(subject).not_to permit(owner, another_behavior)
    end

    it 'allows admin' do
      expect(subject).to permit(admin, behavior)
    end

    it 'prevents admin form accessing other schools' do
      expect(subject).not_to permit(admin, another_behavior)
    end

    it 'allows teacher' do
      expect(subject).to permit(teacher, behavior)
    end

    it 'prevents teacher form accessing other schools' do
      expect(subject).not_to permit(teacher, another_behavior)
    end

    it 'allows parent' do
      expect(subject).to permit(parent, behavior)
    end

    it 'prevents parent form accessing other schools' do
      expect(subject).not_to permit(parent, another_behavior)
    end

    it 'prevents user' do
      expect(subject).not_to permit(user, behavior)
    end
  end

  permissions :index? do
    it 'allows owner' do
      expect(subject).to permit(owner, lesson)
    end

    it 'prevents owner from accessing other schools' do
      expect(subject).not_to permit(owner, another_lesson)
    end

    it 'allows admin' do
      expect(subject).to permit(admin, lesson)
    end

    it 'prevents admin form accessing other schools' do
      expect(subject).not_to permit(admin, another_lesson)
    end

    it 'allows teacher' do
      expect(subject).to permit(teacher, lesson)
    end

    it 'prevents teacher form accessing other schools' do
      expect(subject).not_to permit(teacher, another_lesson)
    end

    it 'prevents parent' do
      expect(subject).not_to permit(parent, lesson)
    end

    it 'prevents user' do
      expect(subject).not_to permit(user, lesson)
    end
  end

  permissions :edit? do
    it 'prevents owner' do
      expect(subject).not_to permit(owner, lesson)
    end

    it 'prevents admin' do
      expect(subject).not_to permit(admin, lesson)
    end

    it 'allows teacher' do
      expect(subject).to permit(teacher, lesson)
    end

    it 'prevents teacher form accessing other schools' do
      expect(subject).not_to permit(teacher, another_lesson)
    end

    it 'prevents parent' do
      expect(subject).not_to permit(parent, lesson)
    end

    it 'prevents user' do
      expect(subject).not_to permit(user, lesson)
    end
  end

  permissions :update? do
    it 'prevents owner' do
      expect(subject).not_to permit(owner, behavior)
    end

    it 'prevents admin' do
      expect(subject).not_to permit(admin, behavior)
    end

    it 'allows teacher' do
      expect(subject).to permit(teacher, behavior)
    end

    it 'prevents teacher form accessing other schools' do
      expect(subject).not_to permit(teacher, another_behavior)
    end

    it 'prevents parent' do
      expect(subject).not_to permit(parent, behavior)
    end

    it 'prevents user' do
      expect(subject).not_to permit(user, behavior)
    end
  end
end
