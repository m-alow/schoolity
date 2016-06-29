require 'capybara/rails'
require 'capybara/rspec'

Dir[Rails.root.join('features/helpers/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('features/pages/**/*.rb')].each { |f| require f }

def fill_in_trix_editor(id, value)
  find(:xpath, "//*[@id='#{id}']", visible: false).set(value)
end
