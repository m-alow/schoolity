require 'rails_helper'
require_relative '../capybara'

feature 'edit exam' do
  let(:classroom) { create(:classroom) }
  let(:teacher) { create(:teaching, classroom: classroom, subject: math).teacher }
  let(:math) { create(:subject, school_class: classroom.school_class) }
  let!(:student) { create(:studying, classroom: classroom).student }
  let!(:student_2) { create(:studying, classroom: classroom).student }
  let(:exam) { create(:exam, score: 60, minimum_score: 24, subject: math, classroom: classroom) }

  before do
    exam.grades.create(student: student, score: 15)
    exam.grades.create(student: student_2, score: 14)
  end

  scenario 'teacher edits a new exam' do
    sign_in_user teacher

    EditExamForm.
      visit_page(exam).
      fill_in_with(
        { score: 60,
          minimum_score: 24,
          scores: [ 40, 50 ]
        }).submit

    expect(page).to have_content 'successfully updated'
    expect(page).to have_content 40
    expect(page).to have_content 50
  end

  scenario 'teacher cannot edit a new exam with invalid data' do
    sign_in_user teacher

        EditExamForm.
      visit_page(exam).
      fill_in_with(
        {
          scores: [ 45, 65 ]
        }).submit

    expect(page).not_to have_content 'successfully updated'
    expect(page).not_to have_content 45
    expect(page).not_to have_content 65
  end
end
