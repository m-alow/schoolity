require 'rails_helper'

RSpec.describe GradeCommentPolicy do
  let(:comment) { create(:comment, commentable: grade) }
  let(:grade) { create(:grade) }
  let(:classroom) { grade.exam.classroom }
  let(:another_comment) { create(:comment, commentable: create(:grade)) }

  let(:owner) { classroom.school.owner }
  let(:admin) { create(:school_administration, administrated_school: classroom.school).administrator }
  let(:teacher) { create(:teaching, classroom: classroom, subject: grade.exam.subject).teacher }
  let(:parent) { create(:following, student: grade.student).user }

  subject { described_class }

  permissions :create? do
    it 'allows owner' do
      expect(subject).to permit(owner, comment)
    end

    it 'prevents owner from commenting in other schools' do
      expect(subject).not_to permit(owner, another_comment)
    end

    it 'allows admin' do
      expect(subject).to permit(admin, comment)
    end

    it 'prevents admin from commenting in other schools' do
      expect(subject).not_to permit(admin, another_comment)
    end

    it 'allows teacher' do
      expect(subject).to permit(teacher, comment)
    end

    it 'prevents teacher from commenting in other schools' do
      expect(subject).not_to permit(teacher, another_comment)
    end

    it 'allows parent' do
      expect(subject).to permit(parent, comment)
    end

    it 'prevents parent from commenting in other schools' do
      expect(subject).not_to permit(parent, another_comment)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(create(:user), comment)
    end
  end
end
