require 'rails_helper'
require_relative '../capybara'

feature 'view exams' do
  let(:classroom) { create(:classroom) }
  let(:teacher) { create(:teaching, classroom: classroom, subject: math).teacher }
  let(:math) { create(:subject, school_class: classroom.school_class, name: 'Math') }
  let(:physics) { create(:subject, school_class: classroom.school_class, name: 'Physics') }
  let!(:student) { create(:studying, classroom: classroom).student }
  let!(:student_2) { create(:studying, classroom: classroom).student }
  let(:exam) { create(:exam, score: 60, minimum_score: 24, subject: math, classroom: classroom) }

  before do
    exam.grades.create(student: student, score: 15)
    exam.grades.create(student: student_2, score: 14)
  end

  scenario 'teacher views a exam' do
    sign_in_user teacher

    ExamsListPage.
      visit_page(classroom)
    click_on math.name

    expect(page).to have_content exam.score
    expect(page).to have_content exam.minimum_score
    expect(page).to have_content exam.description
    expect(page).to have_content 15
    expect(page).to have_content 14
    expect(page).to have_content student.name
    expect(page).to have_content student_2.name
  end
end
