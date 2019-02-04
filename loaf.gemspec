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

  spec.files         = Dir['{lib,spec,config}/**/*'].reject { |f|
                         File.directory?(f) || f.include?('.sqlite3') || f.include?('.log')
                       }
  spec.files        += Dir['{bin,tasks}/*', 'loaf.gemspec']
  spec.files        += Dir['README.md', 'CHANGELOG.md', 'LICENSE.txt', 'Rakefile', 'Appraisals']
  spec.require_paths = ["lib"]

  if spec.respond_to?(:metadata=)
    spec.metadata = {
      'allowed_push_host' => 'https://rubygems.org',
      'bug_tracker_uri'   => 'https://github.com/piotrmurach/loaf/issues',
      'source_code_uri'   => 'https://github.com/piotrmurach/loaf',
      'changelog_uri'     => 'https://github.com/piotrmurach/loaf/blob/master/CHANGELOG.md'
    }
  end

  spec.add_dependency 'rails', '>= 3.2'

  spec.add_development_dependency 'bundler', '>= 1.5'
  spec.add_development_dependency 'rake'
end
