require 'rails_helper'
require_relative '../capybara'

feature 'add student' do
  let(:school) { create(:active_school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:school_class) { create(:school_class, school: school) }
  let(:classroom) { create(:classroom, school_class: school_class) }

  scenario 'to a school by school admin' do
    sign_in_user school_admin

    NewStudentForm.
      visit_page_from_school(school).
      fill_in_with(
        first_name: 'First',
        last_name: 'Last',
        father_name: 'Father',
        mother_name: 'Mother',
        birthdate: Date.new(1994,3,25)
      ).submit

    expect(page).to have_content 'successfully added'
    expect(page).to have_content 'First Last'
    expect(page).to have_content school.name
  end

  scenario 'to a classroom by school admin' do
    sign_in_user school_admin

    NewStudentForm.
      visit_page_from_classroom(classroom).
      fill_in_with(
        first_name: 'First',
        last_name: 'Last',
        father_name: 'Father',
        mother_name: 'Mother',
        birthdate: Date.new(1994,3,25),
        beginning_date: Date.new(2015, 10, 10)
      ).submit

    expect(page).to have_content 'successfully added'
    expect(page).to have_content 'First Last'
    expect(page).to have_content school.name
    expect(page).to have_content classroom.name
    expect(page).to have_content classroom.school_class.name
  end

  scenario 'can not add student with invalid data to school' do
    sign_in_user school_admin

    NewStudentForm.
      visit_page_from_school(school).
      fill_in_with(
        first_name: ''
      ).submit
    expect(page).not_to have_content 'successfully added'
    expect(page).not_to have_content school.name
  end


  scenario 'can not add student with invalid data to classroom' do
    sign_in_user school_admin

    NewStudentForm.
      visit_page_from_classroom(classroom).
      fill_in_with(
        first_name: ''
      ).submit
    expect(page).not_to have_content 'successfully added'
    expect(page).not_to have_content school.name
    expect(page).not_to have_content classroom.name
    expect(page).not_to have_content classroom.school_class.name
  end
end
