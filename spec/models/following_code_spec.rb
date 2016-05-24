require 'rails_helper'

RSpec.describe FollowingCode, type: :model do
  it { should belong_to :student }
  it { should validate_presence_of :student }
  it { should validate_presence_of :code }
  it { should validate_presence_of :expire_at }
  it { should validate_length_of(:code).is_equal_to(8) }

  describe 'a new following code' do
    let(:student) { build(:student) }
    let(:following_code) { FollowingCode.make student }

    it 'is valid' do
      expect(following_code).to be_valid
    end

    it 'has a code of length 8' do
      expect(following_code.code.length).to be 8
    end

    it 'expires after 72 hours' do
      Timecop.freeze DateTime.new(2015) do
        expect(following_code.expire_at - DateTime.now).to eq 72.hours
        Timecop.travel DateTime.new(2015) + 72.hours
        expect(following_code.expired?).to be true
      end
    end

    it 'does not expire before 72 hours' do
      Timecop.freeze(DateTime.new(2015)) do
        following_code
        Timecop.travel DateTime.new(2015) + 72.hours - 1.second
        expect(following_code.expired?).to be false
      end
    end
  end

end
