require 'spec_helper'

describe Loaf::Translation do

  before do
    I18n.backend = I18n::Backend::Simple.new
  end

  it 'translates breadcrumb title' do
    I18n.backend.store_translations 'en', :breadcrumbs => { :home => 'Home'}
    described_class.breadcrumb_title('breadcrumbs.home').should eql 'Home'
  end

  it 'translates breadcrumb name with default scope' do
    I18n.backend.store_translations 'en', :breadcrumbs => { :home => 'Home'}
    described_class.breadcrumb_title('home').should eql 'Home'
  end

  it 'translates breadcrumb name using default option' do
    described_class.breadcrumb_title('home', :default => 'breadcrumb default name').should eql 'breadcrumb default name'
  end

end # Loaf::Translation
