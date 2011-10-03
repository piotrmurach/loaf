require File.expand_path('../lib/loaf/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "loaf"
  s.authors = [ "Piotr Murach" ]
  s.summary = "Loaf is a breadcrumb managing gem."
  s.description = "Loaf is a breadcrumb managing gem."
  s.version = Loaf::Version::STRING.dup

  s.files = Dir["lib/**/*"] + ["Rakefile", "Gemfile", "README.rdoc"]
  s.require_paths = %w[ lib ]

  s.add_development_dependency 'rails', '~> 3.1.0'
  s.add_development_dependency 'rspec', '~> 2.4.0'
  s.add_development_dependency 'rspec-rails', '>= 2.0.0'
  s.add_development_dependency 'capybara', '>= 0.4.0'
  s.add_development_dependency 'bundler', '~> 1.0.0'
  s.add_development_dependency 'jeweler', '~> 1.6.4'
end
