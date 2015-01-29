# encoding: utf-8

require 'spec_helper'

RSpec.describe Loaf::Translation do

  before { I18n.backend = I18n::Backend::Simple.new }

  after { I18n.backend.reload! }

  it 'translates breadcrumb title' do
    I18n.backend.store_translations 'en', loaf: { breadcrumbs: { home: 'Home'}}
    expect(described_class.find_title('home')).to eql('Home')
  end

  it 'does not translates breadcrumb name with missing scope' do
    I18n.backend.store_translations 'en', breadcrumbs: {home: 'Home'}
    expect(described_class.find_title('home')).to eql('home')
  end

  it 'translates breadcrumb name using default option' do
    expect(described_class.find_title('home', default: 'breadcrumb default name')).to eql('breadcrumb default name')
  end
end
