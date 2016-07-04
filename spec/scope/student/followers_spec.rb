require 'rails_helper'
require 'scope/student/followers'

RSpec.describe Scope::Student::Followers do
  let(:subject) { described_class.new student }
  let(:student) { create(:student) }

  it 'has a role of Follower' do
    expect(subject.role).to eq 'Follower'
  end

  describe '#call' do
    it "returns all the student's followers" do
      f1 = create(:following, student: student).user
      f2 = create(:following, student: student).user

      expect(subject.call).to match_array [f1, f2]
    end

    it 'is empty if there is no follower' do
      expect(subject.call).to be_empty
    end

    it 'does not have other students followers' do
      create(:following)
      expect(subject.call).to be_empty
    end
  end
end
