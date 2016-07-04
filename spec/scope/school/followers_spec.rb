require 'rails_helper'
require 'scope/school/followers'

RSpec.describe Scope::School::Followers do
  let(:subject) { described_class.new school }
  let(:school) { create(:active_school) }

  it 'has a role of Follower' do
    expect(subject.role).to eq 'Follower'
  end

  describe '#call' do
    it "returns all followers of school's students" do
      sc1 = create(:school_class, school: school)
      sc2 = create(:school_class, school: school)
      c1 = create(:classroom, school_class: sc1)
      c2 = create(:classroom, school_class: sc2)
      s1 = create(:studying, classroom: c1).student
      s2 = create(:studying, classroom: c2).student
      f1 = create(:following, student: s1).user
      f2 = create(:following, student: s2).user

      expect(subject.call).to match_array [f1, f2]
    end

    it 'is empty when there is no student' do
      expect(subject.call).to be_empty
    end

    it 'is empty if there is no follower' do
      create(:student, school: school)
      expect(subject.call).to be_empty
    end

    it 'returns followers of students who are in the school but not in any classroom' do
      s = create(:student, school: school)
      f = create(:following, student: s).user
      expect(subject.call).to match_array [f]
    end

    it 'returns followers of the same student' do
      s = create(:student, school: school)
      f1 = create(:following, student: s).user
      f2 = create(:following, student: s).user
      expect(subject.call).to match_array [f1, f2]
    end

    it 'returns the same follower of two students once' do
      s1 = create(:student, school: school)
      s2 = create(:student, school: school)
      f = create(:following, student: s1).user
      create(:following, student: s2, user: f)
      expect(subject.call).to match_array [f]
    end
  end
end
