# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'loaf/version'

Gem::Specification.new do |s|
  s.name        = "loaf"
  s.version     = Loaf::Version::STRING.dup
  s.authors     = ["Piotr Murach"]
  s.email       = [""]
  s.homepage    = "https://github.com/peter-murach/loaf"
  s.summary     = %q{Loaf is a breadcrumb managing gem.}
  s.description = %q{Loaf helps you manage breadcrumbs in your rails app. It aims to handle crumb data through easy dsl and expose it through view helpers without any assumptions about markup.}

  s.rubyforge_project = "tytus"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'rails'

  s.add_development_dependency 'rails'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'bundler'
end
