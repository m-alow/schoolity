require 'rails_helper'

RSpec.describe SchoolClassAnnouncementPolicy do
  let(:announcement) { build :school_class_announcement }
  let(:school_class) { announcement.announceable }
  let(:school) { school_class.school }
  let(:classroom) { build :classroom, school_class: school_class }
  let(:math) { build :subject, school_class: school_class, name: 'Math' }
  let(:student) { create(:studying, classroom: classroom).student }
  let(:another_announcement) { create :school_class_announcement }
  let(:another_school_class) { create :school_class }

  let(:owner) { school.owner }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:teacher) { create(:teaching, classroom: classroom, subject: math).teacher }
  let(:parent) { create(:following, student: student).user }
  let(:user) { build :user }

  subject { described_class }

  permissions :index? do
    it 'allows owner' do
      expect(subject).to permit(owner, school_class)
    end

    it 'prevents owner from accessing announcements in other school classes' do
      expect(subject).not_to permit(owner, another_school_class)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, school_class)
    end

    it 'prevents school admin from accessing announcements in other school classes' do
      expect(subject).not_to permit(school_admin, another_school_class)
    end

    it 'allows teacher' do
      expect(subject).to permit(teacher, school_class)
    end

    it 'prevents teacher from accessing announcements in school classes he is not teaching' do
      expect(subject).not_to permit(teacher, another_school_class)
    end

    it 'allows parent' do
      expect(subject).to permit(parent, school_class)
    end

    it 'prevents parent from accessing announcements in school classes he follows no student in' do
      expect(subject).not_to permit(parent, another_school_class)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, school_class)
    end
  end

  permissions :show? do
    it 'allows owner' do
      expect(subject).to permit(owner, announcement)
    end

    it 'prevents owner from accessing announcements in other school classes' do
      expect(subject).not_to permit(owner, another_announcement)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, announcement)
    end

    it 'prevents school admin from accessing announcements in other school classes' do
      expect(subject).not_to permit(school_admin, another_announcement)
    end

    it 'allows teacher' do
      expect(subject).to permit(teacher, announcement)
    end

    it 'prevents teacher from accessing announcements in school classes he is not teaching in' do
      expect(subject).not_to permit(teacher, another_announcement)
    end

    it 'allows parent' do
      expect(subject).to permit(parent, announcement)
    end

    it 'prevents parent from accessing announcements in school classes he follows no student in' do
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

    it 'prevents owner from accessing announcements in other school classes' do
      expect(subject).not_to permit(owner, another_announcement)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, announcement)
    end

    it 'prevents school admin from accessing announcements in other school classes' do
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

    it 'prevents owner from accessing announcements in other school_class' do
      expect(subject).not_to permit(owner, another_announcement)
    end

    it 'allows author school admin' do
      announcement.author = school_admin
      expect(subject).to permit(school_admin, announcement)
    end

    it 'prevents non author school admin' do
      expect(subject).not_to permit(school_admin, announcement)
    end

    it 'prevents school admin from accessing announcements in other school_class' do
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
