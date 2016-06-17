require 'rails_helper'

RSpec.describe Grade, type: :model do
  describe 'validation' do
    it { should validate_presence_of :exam }
    it { should validate_presence_of :student }
    it { should validate_presence_of :score }

    describe 'score' do
      let(:exam) { build(:exam, score: 10) }
      it 'is invalid when score is less than zero' do
        expect(build(:grade, score: -1)).to be_invalid
      end

      it 'is valid when score is equal to zero' do
        expect(build(:grade, score: 0)).to be_valid
      end

      it "is invalid when score is greater than exam's score" do
        expect(build(:grade, score: 11, exam: exam)).to be_invalid
      end

      it "is valid when score is equal to than exam's score" do
        expect(build(:grade, score: 10, exam: exam)).to be_valid
      end
    end
  end

  describe '#pass?' do
    let(:exam) { build(:exam, score: 10, minimum_score: 4) }

    it "passes when score is greater than exam's minimum score" do
      expect(build(:grade, exam: exam, score: 5).pass?).to be true
    end

    it "passes when score is equal to exam's minimum score" do
      expect(build(:grade, exam: exam, score: 4).pass?).to be true
    end

    it "passes when exam's minimum score is not defined" do
      exam.minimum_score = nil
      expect(build(:grade, exam: exam, score: 4).pass?).to be true
    end

    it "fails when score is less than exam's minimum score" do
      expect(build(:grade, exam: exam, score: 3).pass?).to be false
    end
  end
end
