rails_versions = [
  %w[3.2 3.2.22.5],
  %w[4.0 4.0.13],
  %w[4.1 4.1.16],
  %w[4.2 4.2.11],
  %w[5.0 5.0.7],
  %w[5.1 5.1.7],
  %w[5.2 5.2.4],
  %w[6.0 6.0.3],
  %w[6.1 6.1.0],
  %w[7.0 7.0.1]
]

rails_versions.each do |(version, rails)|
  gem_version = Gem::Version.new(version)

  appraise "rails#{version}" do
    gem "railties", "~> #{rails}"
    gem "capybara", "~> 2.18.0"

    if gem_version == Gem::Version.new("3.2")
      gem "tzinfo", "~> 0.3"
    end

    if gem_version <= Gem::Version.new("4.0")
      gem "test-unit", "~> 3.0"
    end
  end
end
