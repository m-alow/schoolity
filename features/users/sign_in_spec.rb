require 'rails_helper'
require_relative '../capybara'


feature 'sign in' do
  let(:user) { create(:user, email: 'me@mail.com', password: '123123123') }

  scenario 'user can sign in' do
    SignInForm.
      visit_page.
      fill_in_with(
        email: user.email,
        password: user.password
      ).submit

    expect(page).to have_content 'Signed in successfully'
  end

  scenario 'user can not sign in with invalid password' do
    SignInForm.
      visit_page.
      fill_in_with(
        email: user.email,
        password: '111111111'
      ).submit

    expect(page).not_to have_content 'Signed in successfully'
  end

  scenario 'visitor can not sign in' do
    SignInForm.
      visit_page.
      fill_in_with(
        email: 'guest@mail.com',
        password: '123123123'
      ).submit

    expect(page).not_to have_content 'Signed in successfully'
  end

end
