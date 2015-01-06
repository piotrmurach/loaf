# encoding: utf-8

require 'spec_helper'

RSpec.describe Loaf::Translation do

  before { I18n.backend = I18n::Backend::Simple.new }

  it 'translates breadcrumb title' do
    I18n.backend.store_translations 'en', :breadcrumbs => { :home => 'Home'}
    expect(described_class.breadcrumb_title('breadcrumbs.home')).to eql('Home')
  end

  it 'translates breadcrumb name with default scope' do
    I18n.backend.store_translations 'en', breadcrumbs: {home: 'Home'}
    expect(described_class.breadcrumb_title('home')).to eql('Home')
  end

  it 'translates breadcrumb name using default option' do
    expect(described_class.breadcrumb_title('home', default: 'breadcrumb default name')).to eql('breadcrumb default name')
  end
end
