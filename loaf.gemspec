require_relative "lib/loaf/version"

Gem::Specification.new do |spec|
  spec.name        = "loaf"
  spec.version     = Loaf::VERSION.dup
  spec.authors     = ["Piotr Murach"]
  spec.email       = ["piotr@piotrmurach.com"]
  spec.summary     = %q{Loaf manages and displays breadcrumb trails in your Rails application.}
  spec.description = %q{Loaf manages and displays breadcrumb trails in your Rails app. It aims to handle breadcrumb data through easy dsl and expose it through view helpers without any assumptions about markup.}
  spec.homepage    = "https://github.com/piotrmurach/loaf"
  spec.license     = "MIT"
  if spec.respond_to?(:metadata=)
    spec.metadata = {
      "allowed_push_host" => "https://rubygems.org",
      "bug_tracker_uri"   => "https://github.com/piotrmurach/loaf/issues",
      "changelog_uri"     => "https://github.com/piotrmurach/loaf/blob/master/CHANGELOG.md",
      "documentation_uri" => "https://www.rubydoc.info/gems/loaf",
      "homepage_uri"      => spec.homepage,
      "source_code_uri"   => "https://github.com/piotrmurach/loaf",
    }
  end
  spec.files         = Dir["{lib,config}/**/*"]
  spec.extra_rdoc_files = Dir["README.md", "CHANGELOG.md", "LICENSE.txt"]
  spec.bindir        = "exe"
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 1.9.3"

  spec.add_dependency "railties", ">= 3.2"

  spec.add_development_dependency "rake"
end
