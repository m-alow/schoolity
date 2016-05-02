require 'rails_helper'
require_relative '../capybara'

feature 'visit home page' do
  scenario 'visit' do
    visit '/'

    expect(page).to have_css('h1', 'Schoolity')
    expect(page).to have_css('.btn', 'Join')
    expect(page).to have_css('.btn', 'Sign in')
  end
end
