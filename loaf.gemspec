# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'loaf/version'

Gem::Specification.new do |spec|
  spec.name        = 'loaf'
  spec.version     = Loaf::VERSION.dup
  spec.authors     = ['Piotr Murach']
  spec.email       = [""]
  spec.homepage    = 'https://github.com/piotrmurach/loaf'
  spec.summary     = %q{Loaf manages and displays breadcrumb trails in your Rails application.}
  spec.description = %q{Loaf manages and displays breadcrumb trails in your Rails app. It aims to handle breadcrumb data through easy dsl and expose it through view helpers without any assumptions about markup.}

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['source_code_uri'] = 'https://github.com/piotrmurach/loaf'
  spec.metadata['changelog_uri'] = 'https://github.com/piotrmurach/loaf/blob/master/CHANGELOG.md'

  spec.add_dependency 'rails', '>= 3.2'

  spec.add_development_dependency 'bundler', '>= 1.5'
  spec.add_development_dependency 'rake'
end
