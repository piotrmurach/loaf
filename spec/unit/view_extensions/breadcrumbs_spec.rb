# encoding: utf-8

RSpec.describe Loaf::ViewExtensions, '#breadcrumbs' do
  it "yields to block all breadcrumbs" do
    instance = DummyView.new
    instance.set_path('/')
    instance.breadcrumb('home', :home_path)
    instance.breadcrumb('posts', :posts_path)

    yielded = []
    block = -> (name, url, styles) { yielded << [name, url, styles] }
    expect {
      instance.breadcrumbs(&block)
    }.to change { yielded.size }.from(0).to(2)
  end

  it "resolves breadcrumb paths" do
    instance = DummyView.new
    instance.breadcrumb('home', :home_path)
    instance.breadcrumb('posts', :posts_path)

    yielded = []
    block = -> (name, url, styles) { yielded << [name, url, styles] }

    instance.breadcrumbs(&block)

    expect(yielded).to eq([
      ['home', '/', ''],
      ['posts', '/posts', '']
    ])
  end

  it "checks current path and provides styles" do
    instance = DummyView.new
    instance.breadcrumb('home', :home_path)
    instance.breadcrumb('posts', :posts_path)

    allow(instance).to receive(:current_page?).with('/').and_return(false)
    allow(instance).to receive(:current_page?).with('/posts').and_return(true)

    yielded = []
    block = -> (name, url, styles) { yielded << [name, url, styles] }
    instance.breadcrumbs(&block)

    expect(yielded).to eq([
      ['home', '/', ''],
      ['posts', '/posts', 'selected']
    ])
  end

  it "allows to force current path" do
    instance = DummyView.new
    instance.breadcrumb('home', :home_path)
    instance.breadcrumb('posts', :posts_path, force: true)

    allow(instance).to receive(:current_page?).and_return(false)

    yielded = []
    block = -> (name, url, styles) { yielded << [name, url, styles] }
    instance.breadcrumbs(&block)

    expect(yielded).to eq([
      ['home', '/', ''],
      ['posts', '/posts', 'selected']
    ])
  end

  it "returns enumerator without block" do
    instance = DummyView.new
    instance.breadcrumb('home', :home_path)
    instance.breadcrumb('posts', :posts_path)

    result = instance.breadcrumbs

    expect(result).to be_a(Enumerable)
    expect(result.take(2)).to eq([
      ['home', '/', ''],
      ['posts', '/posts', '']
    ])
  end

  it 'validates passed options' do
    instance = DummyView.new
    block = -> (name, url, styles) {  }
    expect {
      instance.breadcrumbs(unknown: true, &block)
    }.to raise_error(Loaf::InvalidOptions)
  end

  it 'uses global configuration for crumb formatting' do
    allow(Loaf.configuration).to receive(:crumb_length).and_return(10)
    instance = DummyView.new
    instance.breadcrumb('home-sweet-home', :home_path)
    instance.breadcrumb('posts-for-everybody', :posts_path)

    yielded = []
    block = -> (name, url, styles) { yielded << [name, url, styles] }
    instance.breadcrumbs(&block)

    expect(yielded).to eq([
      ['home-sw...', '/', ''],
      ['posts-f...', '/posts', '']
    ])
  end

  it "allows to overwrite global configuration" do
    allow(Loaf.configuration).to receive(:crumb_length).and_return(10)
    instance = DummyView.new
    instance.breadcrumb('home-sweet-home', :home_path)
    instance.breadcrumb('posts-for-everybody', :posts_path)

    yielded = []
    block = -> (name, url, styles) { yielded << [name, url, styles] }
    instance.breadcrumbs(crumb_length: 15, &block)

    expect(yielded).to eq([
      ['home-sweet-home', '/', ''],
      ['posts-for-ev...', '/posts', '']
    ])
  end
end
