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

  describe '#teacher?' do
    it 'returns true if he teaches in some classroom' do
      user = create(:teaching).teacher
      expect(user.teacher?).to be true
    end

    it 'returns false if he is not teaching at all' do
      user = create(:user)
      expect(user.teacher?).to be false
    end
  end

  describe 'teaches' do
    let(:school) { build(:active_school) }
    let(:school_class) { build(:school_class, school: school) }
    let!(:classroom) { build(:classroom, school_class: school_class) }
    let(:math) { create(:subject, school_class: school_class, name: 'Math') }
    let(:another_subject) { create(:subject, school_class: school_class) }
    let(:teacher) { create(:teaching, classroom: classroom).teacher }
    let(:student) { create(:studying, classroom: classroom).student }

    it 'in his classroom' do
      expect(teacher.teaches_in_classroom? classroom).to be true
    end

    it 'not in other classrooms' do
      expect(teacher.teaches_in_classroom? build(:classroom)).to be false
    end

    it 'a subject in classroom' do
      teacher.teachings.create subject: math, classroom: classroom
      expect(teacher.teaches_subject_in_classroom? math, classroom).to be true
    end

    it 'a subject in classroom if he is teaching all subjects' do
      teacher.teachings.create classroom: classroom, all_subjects: true
      expect(teacher.teaches_subject_in_classroom? math, classroom).to be true
    end

    it 'not another subject in classroom' do
      expect(teacher.teaches_subject_in_classroom? another_subject, classroom).to be false
    end

    it 'not a subject in another classroom even if he is teaching all subjects somewhere else' do
      teacher.teachings.create classroom: classroom, all_subjects: true
      another_classroom = create(:classroom, school_class: school_class)
      another_subject = create(:subject, school_class: another_classroom.school_class)
      expect(teacher.teaches_subject_in_classroom? another_subject, another_classroom).to be false
    end

    it 'in school class' do
      expect(teacher.teaches_in_school_class? school_class).to be true
    end

    it 'not in other school classes' do
      expect(teacher.teaches_in_school_class? build(:school_class)).to be false
    end

    it 'in school' do
      expect(teacher.teaches_in_school? school).to be true
    end

    it 'not in other schools' do
      expect(teacher.teaches_in_school? build(:school)).to be false
    end

    it 'a student' do
      expect(teacher.teaches_student? student).to be true
    end

    it 'not other students' do
      expect(teacher.teaches_student? build(:student)).to be false
    end

    it 'student a subject' do
      teacher.teachings.create classroom: classroom, subject: math
      expect(teacher.teaches_student_a_subject?(student, math)).to be true
    end

    it 'student a subject if he is teaching all subjects' do
      teacher.teachings.create classroom: classroom, all_subjects: true
      expect(teacher.teaches_student_a_subject?(student, math)).to be true
    end

    it 'not student a subject he is not teaching' do
      teacher.teachings.create classroom: classroom, subject: math
      expect(teacher.teaches_student_a_subject?(student, another_subject)).to be false
    end

    it 'not student a subject if student is not in classroom' do
      teacher.teachings.create classroom: create(:classroom, school_class: school_class), subject: math
      expect(teacher.teaches_student_a_subject?(student, another_subject)).to be false
    end
  end
end
