# encoding: utf-8

require 'rubygems'
require 'bundler/setup'
require 'bundler/gem_tasks'

# Run the test with "rake" or "rake test"
desc "Default: run acts_as_list unit tests."
task default: :spec

FileList['tasks/**/*.rake'].each(&method(:import))

desc 'Run all specs'
task ci: %w[ spec ]
