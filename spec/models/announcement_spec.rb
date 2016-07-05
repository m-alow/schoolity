require 'rails_helper'

RSpec.describe Announcement, type: :model do
  it { should belong_to :announceable }
  it { should belong_to :author }
  it { should have_many :comments }

  it { should validate_presence_of :announceable }
  it { should validate_presence_of :author }
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it '#for_school? is true when the announceable is school' do
    school = build(:school)
    announcement = school.announcements.build
    expect(announcement.for_school?).to be true
  end

  it '#for_school_class? is true when the announceable is school class' do
    school_class = build(:school_class)
    announcement = school_class.announcements.build
    expect(announcement.for_school_class?).to be true
  end

  it '#for_classroom? is true when the announceable is classroom' do
    classroom = build(:classroom)
    announcement = classroom.announcements.build
    expect(announcement.for_classroom?).to be true
  end

  describe 'factories' do
    it 'has a valid school factory' do
      expect(build(:school_announcement)).to be_valid
    end

    it 'has a valid school_class factory' do
      expect(build(:school_class_announcement)).to be_valid
    end

    it 'has a valid classroom factory' do
      expect(build(:classroom_announcement)).to be_valid
    end
  end
end
