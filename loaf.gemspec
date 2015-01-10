# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'loaf/version'

Gem::Specification.new do |s|
  s.name        = "loaf"
  s.version     = Loaf::VERSION.dup
  s.authors     = ["Piotr Murach"]
  s.email       = [""]
  s.homepage    = "https://github.com/peter-murach/loaf"
  s.summary     = %q{Loaf is a breadcrumb managing gem.}
  s.description = %q{Loaf helps you manage breadcrumbs in your rails app. It aims to handle crumb data through easy dsl and expose it through view helpers without any assumptions about markup.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'rails', '>= 3.1'
end
