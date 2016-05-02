require 'rails_helper'
require_relative '../capybara'
require_relative '../pages/sign_up_form'

feature 'create a new account' do
  let(:sign_up_form) { SignUpForm.new }

  scenario 'visitor can sign up' do
    sign_up_form.
      visit_page.
      fill_in_with(
        first_name: 'Mohammad',
        last_name: 'Alow',
        email: 'me@mail.com',
        password: '123123123',
        password_confirmation: '123123123'
      ).submit

    expect(page).to have_content 'signed up'
  end

  scenario 'visitor can not sign up with invalid data' do
    sign_up_form.
      visit_page.
      fill_in_with(
        first_name: ''
      ).submit

    expect(page).not_to have_content 'signed up'
  end
end
