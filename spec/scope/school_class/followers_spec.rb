require 'rails_helper'
require 'scope/school_class/followers'

RSpec.describe Scope::SchoolClass::Followers do
  let(:subject) { described_class.new school_class }
  let(:school_class) { create :school_class }
  let(:classroom) { create :classroom, school_class: school_class }

  it 'has a role of Follower' do
    expect(subject.role).to eq 'Follower'
  end

  describe '#call' do
    it "returns all the followers of the class' students" do
      c1 = create(:classroom, school_class: school_class)
      c2 = create(:classroom, school_class: school_class)
      s1 = create(:studying, classroom: c1).student
      s2 = create(:studying, classroom: c2).student
      s3 = create(:studying, classroom: c1).student
      f1 = create(:following, student: s1).user
      f2 = create(:following, student: s2).user
      f3 = create(:following, student: s3).user
      expect(subject.call).to match_array [f1, f2, f3]
    end

    it 'has no follower of students in other classes in the same school' do
      sc = create(:school_class, school: school_class.school)
      c = create(:classroom, school_class: sc)
      create(:studying, classroom: c)

      expect(subject.call).to be_empty
    end

    it 'has no follower if there is no classroom' do
      expect(subject.call).to be_empty
    end

    it 'has no follower if there is no student' do
      create(:classroom, school_class: school_class)
      expect(subject.call).to be_empty
    end

    it 'returns the same follower of two students in the same classroom once' do
      s1 = create(:studying, classroom: classroom).student
      s2 = create(:studying, classroom: classroom).student
      f = create(:following, student: s1).user
      create(:following, student: s2, user: f)

      expect(subject.call).to match_array [f]
    end

    it 'returns the same follower of two students in the same class but different classrooms once' do
      s1 = create(:studying, classroom: classroom).student
      s2 = create(:studying, classroom: create(:classroom, school_class: school_class)).student
      f = create(:following, student: s1).user
      create(:following, student: s2, user: f)

      expect(subject.call).to match_array [f]
    end

    it 'returns followers of the same student' do
      s1 = create(:studying, classroom: classroom).student
      f1 = create(:following, student: s1).user
      f2 = create(:following, student: s1).user

      expect(subject.call).to match_array [f1, f2]
    end

    xit 'has no follower of previous student'
  end
end
