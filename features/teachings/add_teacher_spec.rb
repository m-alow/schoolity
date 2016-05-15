require 'rails_helper'
require_relative '../capybara'

feature 'add teacher' do
  let(:school) { create(:active_school) }
  let(:school_class) { create(:school_class, school: school) }
  let(:classroom) { create(:classroom, school_class: school_class) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:teacher) { create(:user) }
  let(:a_subject) { @a_subject }

  background do
    @a_subject = create(:subject, school_class: school_class)
  end

  scenario 'school admin adds teacher to a classroom' do
    sign_in_user school_admin

    NewTeachingForm.
      visit_page(classroom).
      fill_in_with(
        email: teacher.email,
        subject: a_subject.name,
        all_subjects: false
      ).submit

    expect(page).to have_content 'successfully added'
    expect(page).to have_content teacher.name
  end

  scenario 'school admin cannot add a teacher to a classroom with invalid data' do
    sign_in_user school_admin

    NewTeachingForm.
      visit_page(classroom).
      fill_in_with(
        email: teacher.email,
        subject: '',
        all_subjects: false
      ).submit

    expect(page).not_to have_content 'successfully added'
    expect(page).not_to have_content teacher.name
  end
end
