require 'rails_helper'

RSpec.describe DayBehaviorPolicy do
  let(:behavior) { create :behavior, student: student, behaviorable: day }
  let(:day) { create :day }
  let(:classroom) { day.classroom }
  let(:school) { classroom.school }
  let(:student) { create(:studying, classroom: classroom).student }
  let(:another_day) { create :day }
  let(:another_behavior) { create :behavior, behaviorable: another_day }

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

    it 'prevents teacher' do
      expect(subject).not_to permit(teacher, behavior)
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

  permissions :index?, :edit? do
    it 'allows owner' do
      expect(subject).to permit(owner, day)
    end

    it 'prevents owner from accessing other schools' do
      expect(subject).not_to permit(owner, another_day)
    end

    it 'allows admin' do
      expect(subject).to permit(admin, day)
    end

    it 'prevents admin form accessing other schools' do
      expect(subject).not_to permit(admin, another_day)
    end

    it 'prevents teacher' do
      expect(subject).not_to permit(teacher, day)
    end

    it 'prevents parent' do
      expect(subject).not_to permit(parent, day)
    end

    it 'prevents user' do
      expect(subject).not_to permit(user, day)
    end
  end

  permissions :update? do
    it 'allows owner' do
      expect(subject).to permit(owner, behavior)
    end

    it 'allows admin' do
      expect(subject).to permit(admin, behavior)
    end

    it 'prevents teacher' do
      expect(subject).not_to permit(teacher, behavior)
    end

    it 'prevents parent' do
      expect(subject).not_to permit(parent, behavior)
    end

    it 'prevents user' do
      expect(subject).not_to permit(user, behavior)
    end
  end
end
