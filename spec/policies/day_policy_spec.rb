require 'rails_helper'

RSpec.describe DayPolicy do
  let(:school) { school_class.school }
  let(:school_class) { classroom.school_class }
  let(:classroom) { day.classroom }
  let(:student) { create(:studying, classroom: classroom).student }
  let(:another_classroom) { another_day.classroom }
  let(:day) { build(:day) }
  let(:another_day) { build(:day) }
  let(:owner) { school.owner }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:teacher) { create(:teaching, classroom: classroom).teacher }
  let(:parent) { create(:following, student: student).user }
  let(:user) { build(:user) }

  subject { described_class }

  permissions :index? do
    it 'allows owner' do
      expect(subject).to permit(owner, classroom)
    end

    it 'prevents owner from accessing other schools' do
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

    it 'allows parent' do
      expect(subject).to permit(parent, classroom)
    end

    it 'prevents parent from accessing classrooms he follows no students in' do
      expect(subject).not_to permit(parent, another_classroom)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, classroom)
    end
  end

  permissions :show_by_date?, :today? do
      it 'allows owner' do
      expect(subject).to permit(owner, day)
    end

    it 'prevents owner from accessing other schools' do
      expect(subject).not_to permit(owner, another_day)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, day)
    end

    it 'prevents school admin from accessing other schools' do
      expect(subject).not_to permit(school_admin, another_day)
    end

    it 'allows teacher' do
      expect(subject).to permit(teacher, day)
    end

    it 'prevents teacher from accessing days he is not teaching' do
      expect(subject).not_to permit(teacher, another_day)
    end

    it 'allows parent' do
      expect(subject).to permit(parent, day)
    end

    it 'prevents parent from accessing days he follows no students in' do
      expect(subject).not_to permit(parent, another_day)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, day)
    end
  end

  permissions :edit?, :update? do
      it 'allows owner' do
      expect(subject).to permit(owner, day)
    end

    it 'prevents owner from accessing other schools' do
      expect(subject).not_to permit(owner, another_day)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, day)
    end

    it 'prevents school admin from accessing other schools' do
      expect(subject).not_to permit(school_admin, another_day)
    end

    it 'allows teacher' do
      expect(subject).to permit(teacher, day)
    end

    it 'prevents teacher from accessing days he is not teaching' do
      expect(subject).not_to permit(teacher, another_day)
    end

    it 'prevents parent' do
      expect(subject).not_to permit(parent, another_day)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, day)
    end
  end


  permissions :destroy? do
      it 'allows owner' do
      expect(subject).to permit(owner, day)
    end

    it 'prevents owner from accessing other schools' do
      expect(subject).not_to permit(owner, another_day)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, day)
    end

    it 'prevents school admin from accessing other schools' do
      expect(subject).not_to permit(school_admin, another_day)
    end

    it 'prevents teacher' do
      expect(subject).not_to permit(teacher, day)
    end

    it 'prevents parent' do
      expect(subject).not_to permit(parent, another_day)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, day)
    end
  end
end
