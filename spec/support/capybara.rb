require 'capybara/rails'
require 'capybara/dsl'

RSpec.configure do |c|
  c.include Capybara::DSL, :file_path => /\bspec\/integration\//
end
Capybara.default_driver   = :rack_test
Capybara.default_selector = :css
