require 'rails_helper'
require_relative '../capybara'

feature 'comment on grade' do
  let(:grade) { create :grade, student: create(:studying).student }
  let(:teacher) { create(:teaching, subject: grade.exam.subject, classroom: grade.exam.classroom).teacher }
  let(:parent) { create(:following, student: grade.student).user }

  scenario 'teacher comments on grade' do
    sign_in_user teacher

    GradePage.visit_as_teacher grade
    CommentForm
      .fill_in_with('Good')
      .submit

    expect(page).to have_content 'Good'
  end

  scenario 'parent comments on grade' do
    sign_in_user parent

    GradePage.visit_as_parent grade
    CommentForm
      .fill_in_with('Good')
      .submit

    expect(page).to have_content 'Good'
  end
end
