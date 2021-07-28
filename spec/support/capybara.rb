require 'capybara/rails'
require 'capybara/dsl'

RSpec.configure do |c|
  c.include Capybara::DSL, :file_path => /\bspec\/integration\//
  c.filter_run_when_matching focus: true
end
Capybara.default_driver   = :rack_test
Capybara.default_selector = :css
