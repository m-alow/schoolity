require 'rails_helper'

RSpec.describe StudentAnnouncementPolicy do
  let(:announcement) { build :student_announcement, announceable: student }
  let(:classroom) { create :classroom }
  let(:school_class) { classroom.school_class }
  let(:school) { student.school }
  let(:math) { build :subject, school_class: school_class, name: 'Math' }
  let(:student) { create(:studying, classroom: classroom).student }
  let(:another_announcement) { create :student_announcement }
  let(:another_student) { create :student }

  let(:owner) { school.owner }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:teacher) { create(:teaching, classroom: classroom, subject: math).teacher }
  let(:parent) { create(:following, student: student).user }
  let(:user) { build :user }

  subject { described_class }

  permissions :index? do
    it 'allows owner' do
      expect(subject).to permit(owner, student)
    end

    it 'prevents owner from accessing announcements in other students' do
      expect(subject).not_to permit(owner, another_student)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, student)
    end

    it 'prevents school admin from accessing announcements in other students' do
      expect(subject).not_to permit(school_admin, another_student)
    end

    it 'prevents teacher' do
      expect(subject).not_to permit(teacher, student)
    end

    it 'prevents teacher from accessing announcements in students he is not teaching' do
      expect(subject).not_to permit(teacher, another_student)
    end

    it 'allows parent' do
      expect(subject).to permit(parent, student)
    end

    it 'prevents parent from accessing announcements in students he follows no student in' do
      expect(subject).not_to permit(parent, another_student)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, student)
    end
  end

  permissions :show? do
    it 'allows owner' do
      expect(subject).to permit(owner, announcement)
    end

    it 'prevents owner from accessing announcements in other students' do
      expect(subject).not_to permit(owner, another_announcement)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, announcement)
    end

    it 'prevents school admin from accessing announcements in other students' do
      expect(subject).not_to permit(school_admin, another_announcement)
    end

    it 'prevents teacher' do
      expect(subject).not_to permit(teacher, announcement)
    end

    it 'allows parent' do
      expect(subject).to permit(parent, announcement)
    end

    it 'prevents parent from accessing announcements in students he follows no student in' do
      expect(subject).not_to permit(parent, another_announcement)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, announcement)
    end
  end

  permissions :new?, :create? do
    it 'allows owner' do
      expect(subject).to permit(owner, announcement)
    end

    it 'prevents owner from accessing announcements in other students' do
      expect(subject).not_to permit(owner, another_announcement)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, announcement)
    end

    it 'prevents school admin from accessing announcements in other students' do
      expect(subject).not_to permit(school_admin, another_announcement)
    end

    it 'prevents teacher' do
      expect(subject).not_to permit(teacher, announcement)
    end

    it 'prevents parent' do
      expect(subject).not_to permit(parent, announcement)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, announcement)
    end
  end

  permissions :edit?, :update?, :destroy? do
    it 'allows author owner' do
      announcement.author = owner
      expect(subject).to permit(owner, announcement)
    end

    it 'prevents non author owner' do
      expect(subject).not_to permit(owner, announcement)
    end

    it 'prevents owner from accessing announcements in other student' do
      expect(subject).not_to permit(owner, another_announcement)
    end

    it 'allows author school admin' do
      announcement.author = school_admin
      expect(subject).to permit(school_admin, announcement)
    end

    it 'prevents non author school admin' do
      expect(subject).not_to permit(school_admin, announcement)
    end

    it 'prevents school admin from accessing announcements in other student' do
      expect(subject).not_to permit(school_admin, another_announcement)
    end

    it 'prevents teacher' do
      expect(subject).not_to permit(teacher, announcement)
    end

    it 'prevents parent' do
      expect(subject).not_to permit(parent, announcement)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, announcement)
    end
  end
end
