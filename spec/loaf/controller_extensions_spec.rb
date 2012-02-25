require 'spec_helper'

describe Loaf::ControllerExtensions do

  class Controller
    def self.helper_method(*args); end
    include Loaf::ControllerExtensions
  end

  let(:name) { stub }
  let(:url) { stub }
  let(:options) { stub }

  context 'classes extending controller_extensions' do
    subject { Controller }
    specify { should respond_to(:add_breadcrumb) }
    specify { should respond_to(:breadcrumb) }
    specify { subject.new.should respond_to(:add_breadcrumb) }
    specify { subject.new.should respond_to(:breadcrumb) }
    specify { subject.new.should respond_to(:add_breadcrumbs) }
    specify { subject.new.should respond_to(:clear_breadcrumbs) }
  end

  context 'class methods' do
    let(:controller) { Controller }
    let(:instance) { Class.new(Controller) }

    it 'invokes before_filter' do
      controller.should_receive(:before_filter)
      controller.add_breadcrumb('name', 'url_path')
    end

    it 'delegates to instance' do
      controller.stub(:before_filter).and_yield instance
      instance.should_receive(:send).with(:add_breadcrumb, name, url, options)
      controller.add_breadcrumb(name, url, options)
    end
  end

  context 'instance methods' do
    let(:controller) { Controller }
    let(:instance) { Controller.new }

    it 'instantiates breadcrumbs container' do
      Loaf::Crumb.should_receive(:new).with(name, url)
      instance.add_breadcrumb(name,url)
    end

    it 'adds breadcrumb to collection' do
      expect do
        instance.add_breadcrumb(name, url)
      end.to change { instance._breadcrumbs.size }.by(1)
    end
  end
end # Loaf::ControllerExtensions
