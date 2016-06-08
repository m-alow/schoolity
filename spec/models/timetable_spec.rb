require 'rails_helper'

RSpec.describe Timetable, type: :model do
  it 'has a valid factory' do
    expect(build(:timetable)).to be_valid
  end

  it { should belong_to :classroom }
  it { should validate_presence_of :classroom }
  it { should_not validate_presence_of :weekends }
  it { should_not validate_presence_of :active }
  it { should validate_presence_of :periods_number }
  it { should validate_numericality_of :periods_number }

  it 'is valid when weekends are days' do
    ['Friday', 'Saturday', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday'].each do |day|
      expect(build(:timetable, weekends: [day])).to be_valid
    end
  end

  it 'is invalid when weekends are not days' do
    expect(build(:timetable, weekends: ['S'])).to be_invalid
  end

  describe 'study_days' do
    it 'returns days not in weekends' do
      timetable = build(:timetable, weekends: ['Monday', 'Friday'])
      expect(timetable.study_days).to eq ['Tuesday', 'Wednesday', 'Thursday', 'Saturday', 'Sunday']
    end

    it 'returns all days when there is no weekends' do
      timetable = build(:timetable, weekends: [])
      expect(timetable.study_days).to eq ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
    end
  end

  describe '.periods_hash' do
    let(:math) { build(:subject, name: 'Math') }
    let(:physics) { build(:subject, name: 'Physics') }

    it 'returns a full hash of periods' do
      timetable = build(:timetable, weekends: ['Tuesday', 'Wednesday', 'Thursday', 'Saturday', 'Sunday'], periods_number: 2)
      fri_1 = timetable.periods.build(day: 'Friday', order: '1', subject: math)
      fri_2 = timetable.periods.build(day: 'Friday', order: '2', subject: physics)
      mon_1 = timetable.periods.build(day: 'Monday', order: '1', subject: physics)
      mon_2 = timetable.periods.build(day: 'Monday', order: '2', subject: math)

      periods_hash = timetable.periods_hash

      expect(periods_hash['Friday'][1]).to eq fri_1
      expect(periods_hash['Friday'][2]).to eq fri_2
      expect(periods_hash['Monday'][1]).to eq mon_1
      expect(periods_hash['Monday'][2]).to eq mon_2
      expect(periods_hash.size).to be 2
      expect(periods_hash.values.map(&:size)).to all be 2
    end
  end

  def create_periods timetable, params
    timetable.build_periods params
    timetable.save
    timetable.reload
  end

  describe '.build_periods' do
    let(:school_class) { timetable.classroom.school_class }
    let(:timetable) { create(:timetable, periods_number: 4) }
    let(:math) { create(:subject, name: 'Math', school_class: school_class) }
    let(:physics) { create(:subject, name: 'Physics', school_class: school_class) }

    it 'using all the parameters' do
      create_periods timetable,  [
        { day: 'Monday', order: 1, subject_id: math.id },
        { day: 'Monday', order: 2, subject_id: physics.id }]
      expect(timetable.periods.count).to be 2
      expect(timetable.periods.map(&:subject)).to match_array [math, physics]
    end

    it 'without subject when the subject does not belong to the timetable school class' do
      create_periods timetable, [ { day: 'Monday', order: 1, subject_id: build(:subject).id } ]
      expect(timetable.periods.map(&:subject)).to eq [nil]
    end

    it 'without subject when subject_id is nil' do
      create_periods timetable, [ { day: 'Monday', order: 1, subject_id: nil } ]
      expect(timetable.periods.map(&:subject)).to eq [nil]
    end

    it 'fails when periods are invalid' do
      create_periods timetable, [ { day: 'Monday', order: 0, subject_id: math.id } ]
      expect(timetable.periods.count).to eq 0
    end
  end

  def update_periods! timetable, params
    timetable.update_periods params
    timetable.save
    timetable.reload
  end

  describe '.update_periods' do
    let(:school_class) { timetable.classroom.school_class }
    let(:timetable) { create(:timetable, periods_number: 4) }
    let(:math) { create(:subject, name: 'Math', school_class: school_class) }
    let(:physics) { create(:subject, name: 'Physics', school_class: school_class) }

    before { create_periods timetable, [ { day: 'Monday', order: 1, subject_id: physics } ] }

    it 'only updates the subject' do
      update_periods! timetable, [ { day: 'Monday', order: 1, subject_id: math.id } ]
      expect(timetable.periods.map(&:subject)).to eq [math]
    end

    it 'does not updates when the period does not exist' do
      update_periods! timetable, [ { day: 'Monday', order: 2, subject_id: math.id } ]
      expect(timetable.periods.map(&:subject)).to eq [physics]
    end

    it 'updates subject to nil if it does not belong to the timetable school class subjects' do
      update_periods! timetable, [ { day: 'Monday', order: 1, subject_id: build(:subject).id } ]
      expect(timetable.periods.map(&:subject)).to eq [nil]
    end

    it 'updates subject to nil if subject_id is nil' do
      update_periods! timetable, [ { day: 'Monday', order: 1, subject_id: nil } ]
      expect(timetable.periods.map(&:subject)).to eq [nil]
    end

    it 'updates timetable.updated_at' do
      expect {
        update_periods! timetable, [ { day: 'Monday', order: 1, subject_id: math.id } ]
      }.to change(timetable, :updated_at)
    end
  end
end
