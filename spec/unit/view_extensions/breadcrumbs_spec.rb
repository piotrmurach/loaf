# encoding: utf-8

RSpec.describe Loaf::ViewExtensions, '#breadcrumbs' do
  it "resolves breadcrumb paths" do
    instance = DummyView.new
    instance.breadcrumb('home', :home_path)
    instance.breadcrumb('posts', :posts_path)
    instance.set_path('/posts')

    expect { |b|
      instance.breadcrumbs(&b)
    }.to yield_successive_args(
      ['home', '/', ''],
      ['posts', '/posts', 'selected']
    )
  end

  it "checks current path and provides styles" do
    instance = DummyView.new
    instance.breadcrumb('home', :home_path)
    instance.breadcrumb('posts',
      {controller: 'foo', action: 'posts', id: '73-title'})
    instance.set_path('/posts')

    expect { |b|
      instance.breadcrumbs(&b)
    }.to yield_successive_args(
      ['home', '/', ''],
      ['posts', '/posts?id=73-title', 'selected']
    )
  end

  it "forces current path" do
    instance = DummyView.new
    instance.breadcrumb('home', :home_path)
    instance.breadcrumb('posts', :posts_path, force: true)
    instance.set_path('/posts')

    expect { |b|
      instance.breadcrumbs(&b)
    }.to yield_successive_args(
      ['home', '/', ''],
      ['posts', '/posts', 'selected']
    )
  end

  it "returns enumerator without block" do
    instance = DummyView.new
    instance.breadcrumb('home', :home_path)
    instance.breadcrumb('posts', :posts_path)
    instance.set_path('/posts')

    result = instance.breadcrumbs

    expect(result).to be_a(Enumerable)
    expect(result.take(2)).to eq([
      ['home', '/', ''],
      ['posts', '/posts', 'selected']
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
    instance.set_path('/posts')

    expect { |b|
      instance.breadcrumbs(&b)
    }.to yield_successive_args(
      ['home-sw...', '/', ''],
      ['posts-f...', '/posts', 'selected']
    )
  end

  it "allows to overwrite global configuration" do
    allow(Loaf.configuration).to receive(:crumb_length).and_return(10)
    instance = DummyView.new
    instance.breadcrumb('home-sweet-home', :home_path)
    instance.breadcrumb('posts-for-everybody', :posts_path)
    instance.set_path('/posts')

    expect { |b|
      instance.breadcrumbs(crumb_length: 15, &b)
    }.to yield_successive_args(
      ['home-sweet-home', '/', ''],
      ['posts-for-ev...', '/posts', 'selected']
    )
  end
end
