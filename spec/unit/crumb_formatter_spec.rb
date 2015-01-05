require 'spec_helper'

describe Loaf::CrumbFormatter do

  let(:formatter) { stub.extend(described_class) }
  let(:crumb) { Loaf::Crumb.new('some randome name', stub) }

  context '#format_name' do
    it 'does not capitalize by default' do
      formatted = formatter.format_name(crumb)
      formatted.should eql 'some randome name'
    end

    it 'capitalizes crumb name' do
      formatted = formatter.format_name(crumb, :capitalize => true)
      formatted.should eql 'Some randome name'
    end

    it 'shortens crumb to provided length' do
      name = 'very long name that is more that 30 characters long'
      crumb = Loaf::Crumb.new(name, stub)
      formatter.should_receive(:truncate).with(name, :length => 30).
        and_return name[0..30]
      formatter.format_name(crumb, :crumb_length => 30).should eql name[0..30]
    end

    it 'returns name error if breadcrumb name is nil' do
      crumb = Loaf::Crumb.new('', stub)
      formatter.format_name(crumb).should eql '[name-error]'
    end
  end

end # Loaf::CrumbFormatter
