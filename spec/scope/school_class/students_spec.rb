require 'rails_helper'
require 'scope/school_class/students'

RSpec.describe Scope::SchoolClass::Students do
  let(:subject) { described_class.new school_class }
  let(:school_class) { create(:school_class) }
  let(:school) { school_class.school }

  it 'has a role of Student' do
    expect(subject.role).to eq 'Student'
  end

  describe '#call' do
    it "returns all the students in the class's classrooms" do
      c1 = create(:classroom, school_class: school_class)
      c2 = create(:classroom, school_class: school_class)
      s1 = create(:studying, classroom: c1).student
      s2 = create(:studying, classroom: c1).student
      s3 = create(:studying, classroom: c2).student

      expect(subject.call).to match_array [s1, s2, s3]
    end

    it 'has no student if there is no classroom' do
      expect(subject.call).to be_empty
    end

    it 'has no student if there is classrooms without students' do
      create(:classroom, school_class: school_class)
      expect(subject.call).to be_empty
    end

    it 'has no student if there students in the school but not in the classrooms' do
      create(:classroom, school_class: school_class)
      create(:student, school: school_class.school)
      expect(subject.call).to be_empty
    end

    it "does not have students in other classes' classrooms in the same school" do
      sc = create(:school_class, school: school)
      c = create(:classroom, school_class: sc)
      create(:studying, classroom: c).student
      expect(subject.call).to be_empty
    end

    xit 'does not have previous students in the classroom'
  end
end
