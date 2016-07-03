require 'rails_helper'
require 'scope/classroom/followers'

RSpec.describe Scope::Classroom::Followers do
  let(:subject) { described_class.new classroom }
  let(:classroom) { create(:classroom) }
  let(:another_classroom) { create(:classroom) }
  let(:another_student) { create(:studying, classroom: another_classroom).student }
  before do
    create(:following, student: another_student)
  end

  it 'has a role: Follower' do
    expect(subject.role).to eq 'Follower'
  end

  describe '#call' do
    it 'is empty if there is no student in classroom' do
      expect(subject.call).to be_empty
    end

    it 'is empty if there is no follower' do
      expect(subject.call).to be_empty
    end

    it 'returns followers of the students in the classroom' do
      s1 = create(:studying, classroom: classroom).student
      s2 = create(:studying, classroom: classroom).student
      f1 = create(:following, student: s1).user
      f2 = create(:following, student: s2).user
      expect(subject.call).to match_array [f1, f2]
    end

    it 'returns followers of the the same student' do
      s1 = create(:studying, classroom: classroom).student
      f1 = create(:following, student: s1).user
      f2 = create(:following, student: s1).user
      expect(subject.call).to match_array [f1, f2]
    end

    it 'returns the followers of two students only once' do
      s1 = create(:studying, classroom: classroom).student
      s2 = create(:studying, classroom: classroom).student
      f1 = create(:following, student: s1).user
      create(:following, student: s2, user: f1)
      expect(subject.call).to match_array [f1]
    end
  end
end
