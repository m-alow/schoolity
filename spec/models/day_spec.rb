require 'rails_helper'

RSpec.describe Day, type: :model do
  it 'has a valid factory' do
    expect(build(:day)).to be_valid
  end

  it { should belong_to :classroom }
  it { should have_many :lessons }
  it { should have_many :behaviors }

  it { should validate_presence_of :classroom }
  it { should validate_presence_of :date }
  it { should validate_presence_of :content_type }
  it { should_not validate_presence_of :content }

  it { should validate_uniqueness_of(:date).scoped_to(:classroom_id) }

  describe '.make' do
      let(:day) { Day.make classroom: nil, date: Date.current, summary: 'Bad day' }

    describe 'a new object' do
      it 'is a Day object' do
        expect(day.class).to be Day
      end

      it 'has basic content type' do
        expect(day.content_type).to eq 'basic'
      end

      it 'has content attributes' do
        expect(day.summary).to eq 'Bad day'
      end

      it 'is no persisted' do
        expect(day).not_to be_persisted
      end

      it 'has no associated lessons' do
        expect(day.lessons).to be_empty
      end
    end
  end

  describe '.make_with_lessons' do
    let(:classroom) { create :classroom }
    let!(:timetable) { classroom.timetables.create! active: true, periods_number: 2, weekends: [] }

    it 'makes a new object' do
      expect(Day).to receive(:make).and_call_original
      Day.make_with_lessons classroom: classroom, date: Date.current, summary: 'Bad day'
    end

    it 'has lessons' do
      date = instance_double(Date, :strftime => 'Monday')
      timetable.build_periods([ { subject_id: nil, order: 1 , day: 'Monday' }, { subject_id: nil, order: 2 , day: 'Monday'} ]).tap do |t|
        t.save
        t.reload
      end

      day = Day.make_with_lessons(classroom: classroom, date: date, summary: 'Bad day')

      expect(day.lessons.size).to eq timetable.periods_number
      expect(day.lessons.map(&:order)).to eq timetable.periods.map(&:order)
      expect(day.lessons.map(&:subject)).to eq timetable.periods.map(&:subject)
    end
  end
end
