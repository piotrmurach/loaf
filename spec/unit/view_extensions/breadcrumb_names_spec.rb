# encoding: utf-8

RSpec.describe Loaf::ViewExtensions, '.breadcrumb_names' do

  it { expect(DummyView.new).to respond_to(:breadcrumb_names) }

  it 'returns an empty array initially' do
    instance = DummyView.new

    expect(instance.breadcrumb_names).to be_empty
  end

  it 'returns all names in order' do
    instance = DummyView.new
    names    = ['Home', 'Users', 'Edit user']
    url      = [:home_path, :users_path, :edit_users_path]

    0.upto(2) do |index|
      instance.breadcrumb(names[index], url[index])
    end

    expect(instance.breadcrumb_names).to eql(names)
  end
end
