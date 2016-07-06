require 'rails_helper'

RSpec.describe Activity, type: :model do
  it { should belong_to :student }
  it { should belong_to :lesson }
  it { should have_many :comments }

  it { should validate_presence_of :student }
  it { should validate_presence_of :lesson }

  describe '#make' do
    let(:math) { build(:subject, name: 'Math') }
    let(:lesson) { Lesson.make day: nil, subject: math, order: 1, title: 'Sum', summary: 'Learn sum' }
    let(:student) { build(:student) }
    let(:activity) { Activity.make student: student, lesson: lesson, notes: 'He was awful.', rating: 5 }

    describe 'a new object' do
      it 'is an Activity object' do
        expect(activity.class).to be Activity
      end

      it 'has basic content type' do
        expect(activity.content_type).to eq 'basic'
      end

      it 'has content attributes' do
        expect(activity.notes).to eq 'He was awful.'
        expect(activity.rating).to eq 5
      end

      it 'is no persisted' do
        expect(activity).not_to be_persisted
      end
    end
  end
end
