require 'rails_helper'
require_relative '../capybara'

feature 'add exam' do
  let(:classroom) { create(:classroom) }
  let(:teacher) { create(:teaching, classroom: classroom, subject: math).teacher }
  let(:math) { create(:subject, school_class: classroom.school_class) }
  let!(:student) { create(:studying, classroom: classroom).student }
  let!(:student_2) { create(:studying, classroom: classroom).student }

  scenario 'teacher adds a new exam' do
    sign_in_user teacher

    NewExamForm.
      visit_page(classroom).
      fill_in_with(
        { score: 60,
          minimum_score: 24,
          subject: math.name,
          scores: [ 50, 56 ]
        }).submit

    expect(page).to have_content 'successfully created'
    expect(page).to have_content 50
    expect(page).to have_content 56
  end

  scenario 'teacher cannot add a new exam with invalid data' do
    sign_in_user teacher

    NewExamForm.
      visit_page(classroom).
      fill_in_with(
        { score: -1,
          minimum_score: 8,
          subject: math.name,
          scores: [ 55, 6 ]
        }).submit

    expect(page).not_to have_content 'successfully created'
  end
end
