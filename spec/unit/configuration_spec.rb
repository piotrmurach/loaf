# encoding: utf-8

RSpec.describe Loaf::Configuration do
  it "allows to set and read attributes" do
    config = Loaf::Configuration.new

    config.crumb_length = 4

    expect(config.crumb_length).to eq(4)
  end

  it "accepts attributes at initialization" do
    options = { crumb_length: 12, style_classes: 'active'}
    config = Loaf::Configuration.new(options)

    expect(config.style_classes).to eq('active')
  end

  it "exports configuration as hash" do
    config = Loaf::Configuration.new
    expect(config.to_hash).to eq({
      capitalize: false,
      crumb_length: 30,
      last_crumb_linked: false,
      locales_path: '/',
      root: true,
      style_classes: 'selected'
    })
  end
end
