# encoding: utf-8

require 'fileutils'
require 'generators/loaf/install_generator'

RSpec.describe Loaf::Generators::InstallGenerator, type: :generator do
  destination File.expand_path("../../../tmp", __FILE__)

  before { prepare_destination }

  it "copies loaf locales to the host application" do
    run_generator
    locale = file("config/locales/loaf.en.yml")
    expect(locale).to exist
    FileUtils.rm_rf(File.expand_path("../../../tmp", __FILE__))
  end
end
