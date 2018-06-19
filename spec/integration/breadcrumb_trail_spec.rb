# encoding: utf-8

RSpec.describe "breadcrumbs trail" do
  include ActionView::TestCase::Behavior

  it "shows root breadcrumb" do
    visit root_path

    within '#breadcrumbs .selected' do
      expect(page.html).to include('<a href="/">Home</a>')
    end
  end

  it "inherits controller breadcrumb and adds index action breadcrumb" do
    visit posts_path

    within '#breadcrumbs' do
      expect(page.html).to include('<a href="/">Home</a>')
      within '.selected' do
        expect(page.html).to include('<a href="/posts">All Posts</a>')
      end
    end
  end

  it 'filters out controller breadcrumb and adds new action breadcrumb' do
    visit new_post_path

    within '#breadcrumbs' do
      expect(page).to_not have_content('Home')
      expect(page).to have_content('New Post')
    end
  end

  it "adds breadcrumb in view with path variable" do
    visit post_path(1)

    within '#breadcrumbs .selected' do
      expect(page.html).to include('<a href="/posts/1">Show Post in view</a>')
    end
  end

  it 'is current when forced' do
    visit new_post_path

    expect(page.current_path).to eq(new_post_path)
    within '#breadcrumbs' do
      expect(page).to have_selector('li.selected', count: 2)
      expect(page.html).to include('<a href="/posts">All</a>')
      expect(page.html).to include('<a href="/posts/new">New Post</a>')
    end
  end

  it "allows for procs in name and url" do
    visit post_comments_path(1)

    within '#breadcrumbs .selected' do
      expect(page.html).to include('<a href="/posts/1/comments">Post comments</a>')
    end
  end

  it "allows for procs in name and url without supplying the controller" do
    visit post_comments_path(1)

    within "#breadcrumbs .selected" do
      expect(page.html).to include(
        '<a href="/posts/1/comments?no_controller=true">'\
        'Post comments No Controller</a>'
      )
    end
  end
end
