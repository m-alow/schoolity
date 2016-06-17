require 'rails_helper'

RSpec.describe Exam, type: :model do
  describe 'validation' do
    it { should belong_to :classroom }
    it { should belong_to :subject }
    it { should have_many :grades }

    it { should validate_presence_of :classroom }
    it { should validate_presence_of :subject }
    it { should validate_presence_of :score }
    it { should_not validate_presence_of :minimum_score }
    it { should validate_presence_of :date }
    it { should_not validate_presence_of :description }

    it { should validate_numericality_of(:score).is_greater_than(0) }
    it { should validate_numericality_of(:minimum_score) }

    it 'is invalid when minimum score is less than or equal to zero' do
      expect(build(:exam, score: 20, minimum_score: 0)).to be_invalid
      expect(build(:exam, score: 20, minimum_score: -1)).to be_invalid
    end

    it 'is invalid when minimum score is greater than score' do
      expect(build(:exam, score: 20, minimum_score: 21)).to be_invalid
    end

    it 'is valid when minimum score is equal to score' do
      expect(build(:exam, score: 20, minimum_score: 20)).to be_valid
    end
  end
end
