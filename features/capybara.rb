require 'capybara/rails'
require 'capybara/rspec'

Dir[Rails.root.join('features/helpers/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('features/pages/**/*.rb')].each { |f| require f }
