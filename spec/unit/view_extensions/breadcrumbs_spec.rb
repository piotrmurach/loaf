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

  it "matches current path with :inclusive option as default" do
    instance = DummyView.new
    instance.breadcrumb('home', :home_path)
    instance.breadcrumb('posts', :posts_path)
    instance.set_path('/posts?id=73-title')

    expect { |b|
      instance.breadcrumbs(&b)
    }.to yield_successive_args(
      ['home', '/', ''],
      ['posts', '/posts', 'selected']
    )
  end

  it "matches current path with :inclusive when query params" do
    view = DummyView.new
    view.breadcrumb('posts', '/posts', match: :inclusive)
    view.set_path('/posts?foo=bar')

    expect(view.breadcrumbs.to_a).to eq([['posts', '/posts', 'selected']])
  end

  it "matches current path with :inclusive when nested" do
    view = DummyView.new
    view.breadcrumb('posts', '/posts', match: :inclusive)
    view.set_path('/posts/1/comment')

    expect(view.breadcrumbs.to_a).to eq([['posts', '/posts', 'selected']])
  end

  it "matches current path with :inclusive when nested" do
    view = DummyView.new
    view.breadcrumb('posts', '/posts', match: :inclusive)
    view.set_path('/posts/1/comment')

    expect(view.breadcrumbs.to_a).to eq([['posts', '/posts', 'selected']])
  end

  it "doesn't match with :inclusive when unrelated path" do
    view = DummyView.new
    view.breadcrumb('posts', '/posts', match: :inclusive)
    view.set_path('/post/1')

    expect(view.breadcrumbs.to_a).to eq([['posts', '/posts', '']])
  end

  it "matches current path with :inclusive when extra trailing slash" do
    view = DummyView.new
    view.breadcrumb('posts', '/posts/', match: :inclusive)
    view.set_path('/posts')

    expect(view.breadcrumbs.to_a).to eq([['posts', '/posts/', 'selected']])
  end

  it "forces current path" do
    instance = DummyView.new
    instance.breadcrumb('home', :home_path)
    instance.breadcrumb('posts', :posts_path, match: :force)
    instance.set_path('/')

    expect { |b|
      instance.breadcrumbs(&b)
    }.to yield_successive_args(
      ['home', '/', 'selected'],
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
