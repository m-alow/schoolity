require 'rails_helper'

RSpec.describe TimetablePolicy do
  let(:school) { build(:active_school, owner: owner) }
  let(:school_class) { build(:school_class, school: school) }
  let(:classroom) { build(:classroom, school_class: school_class) }
  let(:another_classroom) { build(:classroom) }
  let(:timetable) { build(:timetable, classroom: classroom) }
  let(:another_timetable) { build(:timetable) }
  let(:owner) { build(:user) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:parent) { create(:following, student: student).user }
  let(:student) { create(:studying, classroom: classroom).student }
  let(:user) { build(:user) }

  subject { described_class }

  permissions :index? do
    it 'allows school owner' do
      expect(subject).to permit(owner, classroom)
    end

    it 'prevents school owner from accessing timetables in other classrooms' do
      expect(subject).not_to permit(owner, another_classroom)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, classroom)
    end

    it 'prevents school admin from accessing timetables in other classrooms' do
      expect(subject).not_to permit(school_admin, another_classroom)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, classroom)
    end
  end

  permissions :show? do
    it 'allows school owner' do
      expect(subject).to permit(owner, timetable)
    end

    it 'prevents school owner from accessing  timetables in other classrooms' do
      expect(subject).not_to permit(owner, another_timetable)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, timetable)
    end

    it 'prevents school admin from accessing timetables in other classrooms' do
      expect(subject).not_to permit(school_admin, another_timetable)
    end

    it 'allows parent' do
      expect(subject).to permit(parent, timetable)
    end

    it 'prevents parent from accessing timetable for non followed students' do
      expect(subject).not_to permit(parent, another_timetable)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, timetable)
    end
  end

  permissions :new?, :init?, :create?, :edit?, :update?, :destroy? do
    it 'allows school owner' do
      expect(subject).to permit(owner, timetable)
    end

    it 'prevents school owner from accessing  timetables in other classrooms' do
      expect(subject).not_to permit(owner, another_timetable)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, timetable)
    end

    it 'prevents parent from' do
      expect(subject).not_to permit(school_admin, another_timetable)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, timetable)
    end
  end
end
