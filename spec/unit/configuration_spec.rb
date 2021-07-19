# frozen_string_literal: true

RSpec.describe Loaf::Configuration do
  it "allows to set and read attributes" do
    config = Loaf::Configuration.new
    config.match = :exact
    expect(config.match).to eq(:exact)
  end

  it "accepts attributes at initialization" do
    options = { locales_path: "/lib", match: :exact }
    config = Loaf::Configuration.new(options)

    expect(config.locales_path).to eq("/lib")
    expect(config.match).to eq(:exact)
  end

  it "exports configuration as hash" do
    config = Loaf::Configuration.new
    expect(config.to_hash).to eq({
      locales_path: "/",
      match: :inclusive,
      http_verbs: [:get]
    })
  end

  it "yields configuration" do
    conf = double(:conf)
    allow(Loaf).to receive(:configuration).and_return(conf)
    expect { |b|
      Loaf.configure(&b)
    }.to yield_with_args(conf)
  end
end
