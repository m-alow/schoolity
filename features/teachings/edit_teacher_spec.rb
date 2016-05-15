require 'rails_helper'
require_relative '../capybara'

feature 'edit teacher' do
  let(:school) { create(:active_school) }
  let(:school_class) { create(:school_class, school: school) }
  let(:classroom) { create(:classroom, school_class: school_class) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:teacher) { create(:teaching, subject: subject, classroom: classroom, all_subjects: false).teacher }
  let(:subject) { create(:subject, school_class: school_class) }


  scenario 'school admin edits teacher' do
    sign_in_user school_admin

    EditTeachingForm.
      visit_page(teacher).
      fill_in_with(
        all_subjects: true
      ).submit

    expect(page).to have_content 'successfully updated'
    expect(page).to have_content 'true'
    expect(page).to have_content teacher.name
  end

  scenario 'school admin cannot edit a teacher with invalid data' do
    sign_in_user school_admin

    EditTeachingForm.
      visit_page(teacher).
      fill_in_with(
        subject: '',
        all_subjects: false
      ).submit

    expect(page).not_to have_content 'successfully updated'
    expect(page).not_to have_content teacher.name
  end
end
