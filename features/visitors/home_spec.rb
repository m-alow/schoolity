require 'rails_helper'
require_relative '../capybara'

feature 'visit home page' do
  scenario 'visit' do
    visit '/'

    expect(page).to have_css('h1', text: 'Schoolity')
    expect(page).to have_css('.btn', text: 'Join')
    expect(page).to have_css('.btn', text: 'Sign in')
  end
end
