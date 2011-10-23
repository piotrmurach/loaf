require File.expand_path('../lib/loaf/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "loaf"
  gem.authors     = [ "Piotr Murach" ]
  gem.email       = ""
  gem.homepage    = 'https://github.com/peter-murach/loaf'
  gem.summary     = "Loaf is a breadcrumb managing gem."
  gem.description = "Loaf helps you manage breadcrumbs in your rails app. It aims to handle crumb data through easy dsl and expose it through view helpers without any assumptions about markup."

  gem.version     = Loaf::Version::STRING.dup

  gem.files = Dir["lib/**/*"] + ["Rakefile", "Gemfile", "README.rdoc"]
  gem.require_paths = %w[ lib ]

  gem.add_development_dependency 'rails', '~> 3.1.0'
  gem.add_development_dependency 'rspec', '~> 2.4.0'
  gem.add_development_dependency 'rspec-rails', '>= 2.0.0'
  gem.add_development_dependency 'capybara', '>= 0.4.0'
  gem.add_development_dependency 'bundler', '~> 1.0.0'
  gem.add_development_dependency 'jeweler', '~> 1.6.4'
end
