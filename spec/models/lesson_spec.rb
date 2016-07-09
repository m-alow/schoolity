require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it 'has a valid factory' do
    expect(build(:lesson)).to be_valid
  end

  it { should belong_to :day }
  it { should belong_to :subject }
  it { should have_many :activities }
  it { should have_many :comments }
  it { should have_many :behaviors }

  it { should validate_presence_of :day }
  it { should_not validate_presence_of :subject }
  it { should validate_presence_of :order }
  it { should validate_presence_of :content_type }
  it { should_not validate_presence_of :content }

  it { should validate_numericality_of(:order).only_integer }

  it { should validate_uniqueness_of(:order).scoped_to(:day_id) }

  describe '.make' do
    let(:math) { build(:subject, name: 'Math') }
    let(:lesson) { Lesson.make day: nil, subject: math, order: 1, title: 'Sum', summary: 'Learn sum' }

    describe 'a new object' do
      it 'is a Lesson object' do
        expect(lesson.class).to be Lesson
      end

      it 'has basic content type' do
        expect(lesson.content_type).to eq 'basic'
      end

      it 'has content attributes' do
        expect(lesson.title).to eq 'Sum'
        expect(lesson.summary).to eq 'Learn sum'
      end

      it 'is no persisted' do
        expect(lesson).not_to be_persisted
      end
    end
  end
end
