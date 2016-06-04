require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'is invalid without a first name' do
    expect(build(:user, first_name: nil)).to be_invalid
  end

  it 'is invalid without a last name' do
    expect(build(:user, last_name: nil)).to be_invalid
  end

  it 'is invalid without an email' do
    expect(build(:user, email: nil)).to be_invalid
  end

  it 'returns the full name as a string' do
    user = build(:user, first_name: 'Mohammad', last_name: 'Alow')
    expect(user.name).to eq 'Mohammad Alow'
  end

  it { should have_many :teachings }

  describe 'follows a student' do
    let(:user) { build(:user) }
    let(:student) { build(:student) }
    let!(:following_code) { FollowingCode.make! student }

    it 'is valid' do
      following = user.follow_student(code: following_code.code, relationship: 'Parent', full_name: student.full_name)
      expect(following).to be_valid
    end

    it 'is invalid with an expired following code' do
      Timecop.travel(Time.now + 100.hours) do
        following = user.follow_student(code: following_code.code, relationship: 'Parent', full_name: student.full_name)
        expect(following).to be_invalid
      end
    end

    it 'is invalid with a mismatching student full name' do
      following = user.follow_student(code: following_code.code, relationship: 'Parent', full_name: 'a')
      expect(following).to be_invalid
    end

    it 'is invalid with a wrong following code' do
      following = user.follow_student(code: "wrong#{following_code.code}", relationship: 'Parent', full_name: student.full_name)
      expect(following).to be_invalid
    end
  end
end
