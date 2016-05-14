require 'rails_helper'
require_relative '../capybara'

feature 'edit subject' do
  let(:school) { create(:active_school) }
  let(:school_class) { create(:school_class, school: school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:a_subject) { create(:subject, name: 'CS', school_class: school_class) }

  scenario 'school admin can edit' do
    sign_in_user school_admin

    EditSubjectForm.
      visit_page(a_subject).
      fill_in_with(
        name: 'Math'
      ).submit

    expect(page).to have_content 'successfully updated'
    expect(page).to have_content 'Math'
  end

  scenario 'school admin cannot edit with invalid data' do
    sign_in_user school_admin

    EditSubjectForm.
      visit_page(a_subject).
      fill_in_with(
        name: ''
      ).submit

    expect(page).not_to have_content 'successfully added'

    SubjectsIndexPage.visit_page(a_subject.school_class)
    expect(page).to have_content 'CS'
  end
end
