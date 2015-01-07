# encoding: utf-8

require 'spec_helper'

RSpec.describe Loaf::CrumbFormatter, '.format_name' do
  let(:formatter) {
    Class.new do
      extend Loaf::CrumbFormatter

      def self.truncate(name, options)
        name
      end
    end
  }

  it 'returns name error if breadcrumb name is nil' do
    expect(formatter.format_name('')).to eql('')
  end

  it "doesn't capitalize by default" do
    name = 'some random name'
    formatted = formatter.format_name(name)
    expect(formatted).to eql(name)
  end

  it 'capitalizes crumb name with capitalize option' do
    name = 'some random name'
    formatted = formatter.format_name(name, capitalize: true)
    expect(formatted).to eql('Some random name')
  end

  it 'shortens crumb to provided length' do
    name = 'very long name that is more that 30 characters long'
    allow(formatter).to receive(:truncate).with(name, length: 30).
      and_return(name[0..30])
    expect(formatter.format_name(name, crumb_length: 30)).to eql(name[0..30])
  end
end
