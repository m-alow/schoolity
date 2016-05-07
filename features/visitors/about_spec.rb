require 'rails_helper'
require_relative '../capybara'

feature 'visiting about page' do
  scenario 'visit' do
    visit '/'
    click_on 'About'

    expect(page).to have_css('h1', text: 'About')
  end
end
