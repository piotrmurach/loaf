# encoding: utf-8

require 'spec_helper'

class DummyController < ActionController::Base
  def self.before_filter(options, &block)
    yield self.new
  end
  class << self
    alias before_action before_filter
  end
  include Loaf::ControllerExtensions
end

RSpec.describe Loaf::ControllerExtensions do

  context 'when classes extend controller_extensions' do
    it { expect(DummyController).to respond_to(:add_breadcrumb) }
    it { expect(DummyController).to respond_to(:breadcrumb) }
    it { expect(DummyController.new).to respond_to(:add_breadcrumb) }
    it { expect(DummyController.new).to respond_to(:breadcrumb) }
    it { expect(DummyController.new).to respond_to(:add_breadcrumbs) }
    it { expect(DummyController.new).to respond_to(:clear_breadcrumbs) }
  end

  context 'class methods' do
    it 'invokes before_filter' do
      allow(DummyController).to receive(:before_action)
      allow(DummyController).to receive(:respond_to?).and_return(true)
      DummyController.breadcrumb('name', 'url_path')
      expect(DummyController).to have_received(:before_action)
    end

    it 'delegates breadcrumb registration to controller instance' do
      name    = 'List objects'
      url     = :object_path
      options = {force: true}
      instance = double(:controller_instance).as_null_object

      allow(DummyController).to receive(:new).and_return(instance)
      DummyController.breadcrumb(name, url, options)
      expect(instance).to have_received(:breadcrumb).with(name, url, options)
    end
  end

  context 'instance methods' do
    it 'instantiates breadcrumbs container' do
      name     = 'List objects'
      url      = :object_path
      instance = DummyController.new

      allow(Loaf::Crumb).to receive(:new)
      instance.breadcrumb(name, url)
      expect(Loaf::Crumb).to have_received(:new).with(name, url, {})
    end

    it 'adds breadcrumb to collection' do
      name     = 'List objects'
      url      = :object_path
      instance = DummyController.new

      expect {
        instance.breadcrumb(name, url)
      }.to change { instance._breadcrumbs.size }.by(1)
    end
  end
end
