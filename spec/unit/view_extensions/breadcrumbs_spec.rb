# encoding: utf-8

RSpec.describe Loaf::ViewExtensions, '#breadcrumbs' do
  it "resolves breadcrumb paths" do
    view = DummyView.new
    view.breadcrumb('home', :home_path)
    view.breadcrumb('posts', :posts_path)
    view.set_path('/posts')

    expect { |b|
      view.breadcrumbs(&b)
    }.to yield_successive_args(
      ['home', '/', ''],
      ['posts', '/posts', 'selected']
    )
  end

  it "matches current path with :inclusive option as default" do
    view = DummyView.new
    view.breadcrumb('home', :home_path)
    view.breadcrumb('posts', :posts_path)
    view.set_path('/posts?id=73-title')

    expect { |b|
      view.breadcrumbs(&b)
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

  it "matches current path with :inclusive when absolute path" do
    view = DummyView.new
    view.breadcrumb('posts', 'http://www.example.com/posts/', match: :inclusive)
    view.set_path('/posts')

    expect(view.breadcrumbs.to_a).to eq([['posts', 'http://www.example.com/posts/', 'selected']])
  end

  it "matches current path with :exact when trailing slash" do
    view = DummyView.new
    view.breadcrumb('posts', '/posts/', match: :exact)
    view.set_path('/posts')

    expect(view.breadcrumbs.to_a).to eq([['posts', '/posts/', 'selected']])
  end

  it "fails to match current path with :exact when nested" do
    view = DummyView.new
    view.breadcrumb('posts', '/posts', match: :exact)
    view.set_path('/posts/1/comment')

    expect(view.breadcrumbs.to_a).to eq([['posts', '/posts', '']])
  end

  it "fails to match current path with :exact when query params" do
    view = DummyView.new
    view.breadcrumb('posts', '/posts', match: :exact)
    view.set_path('/posts?foo=bar')

    expect(view.breadcrumbs.to_a).to eq([['posts', '/posts', '']])
  end

  it "matches current path with :exclusive option when query params" do
    view = DummyView.new
    view.breadcrumb('posts', '/posts', match: :exclusive)
    view.set_path('/posts?foo=bar')

    expect(view.breadcrumbs.to_a).to eq([['posts', '/posts', 'selected']])
  end

  it "fails to match current path with :exclusive option when nested" do
    view = DummyView.new
    view.breadcrumb('posts', '/posts', match: :exclusive)
    view.set_path('/posts/1/comment')

    expect(view.breadcrumbs.to_a).to eq([['posts', '/posts', '']])
  end

  it "matches current path with regex option when query params" do
    view = DummyView.new
    view.breadcrumb('posts', '/posts', match: %r{/po})
    view.set_path('/posts?foo=bar')

    expect(view.breadcrumbs.to_a).to eq([['posts', '/posts', 'selected']])
  end

  it "matches current path with query params option" do
    view = DummyView.new
    view.breadcrumb('posts', '/posts', match: {foo: :bar})
    view.set_path('/posts?foo=bar&baz=boo')

    expect(view.breadcrumbs.to_a).to eq([['posts', '/posts', 'selected']])
  end

  it "fails to match current path with query params option" do
    view = DummyView.new
    view.breadcrumb('posts', '/posts', match: {foo: :bar})
    view.set_path('/posts?foo=2&baz=boo')

    expect(view.breadcrumbs.to_a).to eq([['posts', '/posts', '']])
  end

  it "failse to recognize the match option" do
    view = DummyView.new
    view.breadcrumb('posts', 'http://www.example.com/posts/', match: :boom)
    view.set_path('/posts')
    block = -> (*args) { }
    expect {
      view.breadcrumbs(&block)
    }.to raise_error(ArgumentError, "Unknown `:boom` match option!")
  end

  it "forces current path" do
    view = DummyView.new
    view.breadcrumb('home', :home_path)
    view.breadcrumb('posts', :posts_path, match: :force)
    view.set_path('/')

    expect { |b|
      view.breadcrumbs(&b)
    }.to yield_successive_args(
      ['home', '/', 'selected'],
      ['posts', '/posts', 'selected']
    )
  end

  it "returns enumerator without block" do
    view = DummyView.new
    view.breadcrumb('home', :home_path)
    view.breadcrumb('posts', :posts_path)
    view.set_path('/posts')

    result = view.breadcrumbs

    expect(result).to be_a(Enumerable)
    expect(result.take(2)).to eq([
      ['home', '/', ''],
      ['posts', '/posts', 'selected']
    ])
  end

  it 'validates passed options' do
    view = DummyView.new
    block = -> (name, url, styles) {  }
    expect {
      view.breadcrumbs(unknown: true, &block)
    }.to raise_error(Loaf::InvalidOptions)
  end

  it 'uses global configuration for crumb formatting' do
    allow(Loaf.configuration).to receive(:crumb_length).and_return(10)
    view = DummyView.new
    view.breadcrumb('home-sweet-home', :home_path)
    view.breadcrumb('posts-for-everybody', :posts_path)
    view.set_path('/posts')

    expect { |b|
      view.breadcrumbs(&b)
    }.to yield_successive_args(
      ['home-sw...', '/', ''],
      ['posts-f...', '/posts', 'selected']
    )
  end

  it "allows to overwrite global configuration" do
    allow(Loaf.configuration).to receive(:crumb_length).and_return(10)
    view = DummyView.new
    view.breadcrumb('home-sweet-home', :home_path)
    view.breadcrumb('posts-for-everybody', :posts_path)
    view.set_path('/posts')

    expect { |b|
      view.breadcrumbs(crumb_length: 15, &b)
    }.to yield_successive_args(
      ['home-sweet-home', '/', ''],
      ['posts-for-ev...', '/posts', 'selected']
    )
  end
end
