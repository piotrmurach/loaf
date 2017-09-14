if RUBY_VERSION < '2.2.0'
  appraise 'rails3.2' do
    gem 'rails', '~> 3.2.22.5'
    gem 'test-unit', '~> 3.0'
  end
end

if RUBY_VERSION < '2.4.0'
  appraise 'rails4.0' do
    gem 'rails', '~> 4.0.13'
    gem 'test-unit'
    gem 'mime-types', '~> 2.99'
  end

  appraise 'rails4.1' do
    gem 'rails', '~> 4.1.16'
    gem 'mime-types', '~> 2.99'
  end

  appraise 'rails4.2' do
    gem 'rails', '~> 4.2.9'
    gem 'mime-types', '~> 2.99'
  end
end

if RUBY_VERSION >= '2.2.0'
  appraise 'rails5.0' do
    gem 'rails', '~> 5.0.6'
    gem 'rspec-rails', '~> 3.6.1'
  end

  appraise 'rails5.1' do
    gem 'rails', '~> 5.1.4'
    gem 'rspec-rails', '~> 3.6.1'
  end
end
