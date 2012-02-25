require 'spec_helper'

describe Loaf::ViewExtensions do

  class View < ActionView::Base
    include Loaf::ViewExtensions
    attr_accessor_with_default :_breadcrumbs, []
  end

  let(:name) { 'name' }
  let(:url)  { 'url' }
  let(:view) { View }
  let(:instance) { view.new }

  context 'classes extending view_extensions' do
     subject { View.new }
     specify { should respond_to(:breadcrumb) }
     specify { should respond_to(:add_breadcrumb) }
     specify { should respond_to(:breadcrumbs) }
  end

  context 'adding view breadcrumb' do
    it 'calls breadcrumbs helper' do
      instance.should_receive(:_breadcrumbs).and_return []
      instance.breadcrumb name, url
    end

    it 'creates crumb instance' do
      Loaf::Crumb.should_receive(:new).with(name, url)
      instance.breadcrumb name, url
    end

    it 'should add crumb to breadcrumbs storage' do
      expect do
        instance.breadcrumb name, url
      end.to change { instance._breadcrumbs.size }.by(1)
    end
  end

  context 'breadcrumbs rendering' do

    let(:block) { lambda { |name, url, styles| } }

    before do
      @crumbs = []
      @crumbs << Loaf::Crumb.new('home', :home_path)
      @crumbs << Loaf::Crumb.new('posts', :posts_path)
      instance.stub(:_breadcrumbs).and_return @crumbs

      @options = {}
      Loaf.stub_chain(:config, :merge).and_return @options
      @crumbs.each do |crumb|
        instance.stub(:format_name).with(crumb, @options).and_return crumb.name
        instance.stub(:_process_url_for).with(crumb.url).and_return crumb.name
      end
      instance.stub(:current_page?).and_return true
    end

    it 'validates passed options' do
      instance.should_receive(:valid?)
      instance.breadcrumbs &block
    end

    it 'raises error for unkown option' do
      expect do
        instance.breadcrumbs :unsupported => true, &block
      end.to raise_error(Loaf::InvalidOptions)
    end

    it 'calls loaf configuration' do
      Loaf.should_receive(:config).and_return @options
      @options.should_receive(:merge).with({:crumb_length => 10}).
        and_return @options
      instance.breadcrumbs :crumb_length => 10, &block
    end

    it 'uses breadcrumbs collection helper' do
      instance.should_receive(:_breadcrumbs)
      instance.breadcrumbs &block
    end

    it 'retrieves crumbs collection' do
      instance._breadcrumbs.should eql @crumbs
      instance.breadcrumbs &block
    end

    it 'formats crumb name' do
      instance.should_receive(:format_name)
      instance.breadcrumbs &block
    end

    it 'checks if crumb url is current' do
      instance.should_receive(:current_page?)
      instance.breadcrumbs &block
    end

    context 'rendering inside block' do
      it 'returns crumb attributes' do
        crumb = Loaf::Crumb.new name, url
        instance.stub(:_breadcrumbs).and_return [crumb]
        instance.should_receive(:format_name).with(crumb, @options).
          and_return crumb.name
        instance.should_receive(:_process_url_for).with(crumb.url).
          and_return crumb.name

        instance.breadcrumbs do |name, url, styles|
          name.should eql crumb.name
          url.should eql crumb.name
          styles.should be_blank
        end
      end
    end
  end
end # Loaf::ViewExtensions
