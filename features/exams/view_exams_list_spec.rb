require 'rails_helper'
require_relative '../capybara'

feature 'view exams list' do
  let(:classroom) { create(:classroom) }
  let(:teacher) { create(:teaching, classroom: classroom, subject: math).teacher }
  let(:math) { create(:subject, school_class: classroom.school_class, name: 'Math') }
  let(:physics) { create(:subject, school_class: classroom.school_class, name: 'Physics') }
  let!(:student) { create(:studying, classroom: classroom).student }
  let!(:student_2) { create(:studying, classroom: classroom).student }
  let(:math_exam) { create(:exam, score: 60, minimum_score: 24, subject: math, classroom: classroom) }
  let(:physics_exam) { create(:exam, score: 60, minimum_score: 24, subject: physics, classroom: classroom) }

  before do
    math_exam.grades.create(student: student, score: 15)
    math_exam.grades.create(student: student_2, score: 14)
    physics_exam.grades.create(student: student, score: 15)
    physics_exam.grades.create(student: student_2, score: 14)
  end

  scenario 'teacher views exams list' do
    sign_in_user teacher

    ExamsListPage.
      visit_page(classroom)

    expect(page).to have_content math.name
    expect(page).to have_content physics.name
  end
end
