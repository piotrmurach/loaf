# encoding: utf-8

RSpec.describe "breadcrumbs trail" do
  before do
    include ActionView::TestCase::Behavior
  end

  it "shows root breadcrumb" do
    visit root_path

    page.within '#breadcrumbs .selected' do
      expect(page.html).to include('<a href="/">Home</a>')
    end
  end

  it "inherits controller breadcrumb and adds index action breadcrumb" do
    visit posts_path

    page.within '#breadcrumbs' do
      expect(page.html).to include('<a href="/">Home</a>')
    end
    page.within '#breadcrumbs .selected' do
      expect(page.html).to include('<a href="/posts">All Posts</a>')
    end
  end

  it 'filters out controller breadcrumb and adds new action breadcrumb' do
    visit new_post_path

    page.within '#breadcrumbs' do
      expect(page).to_not have_content('Home')
      expect(page).to have_content('New Post')
    end
  end

  it "adds breadcrumb in view with path variable" do
    visit post_path(1)

    page.within '#breadcrumbs .selected' do
      expect(page.html).to include('<a href="/posts/1">Show Post in view</a>')
    end
  end

  it 'is current when forced' do
    visit new_post_path

    expect(page.current_path).to eq(new_post_path)
    page.within '#breadcrumbs' do
      expect(page).to have_selector('li.selected', count: 2)
      expect(page.html).to include('<a href="/posts">All</a>')
      expect(page.html).to include('<a href="/posts/new">New Post</a>')
    end
  end

  it "allows for procs in name and url" do
    visit post_comments_path(1)

    page.within '#breadcrumbs .selected' do
      expect(page.html).to include('<a href="/posts/1/comments">Post comments</a>')
    end
  end

  it "allows for procs in name and url without supplying the controller" do
    visit post_comments_path(1)

    page.within "#breadcrumbs .selected" do
      expect(page.html).to include(
        '<a href="/posts/1/comments?no_controller=true">'\
        "Post comments No Controller</a>"
      )
    end
  end

  it "match to Non-GET methods" do
    visit onboard_path

    expect(page).to have_selector("h1", text: "Onboard")
    page.within "#breadcrumbs" do
      expect(page).to have_content("Onboard")
    end

    click_link "Step 1" # GET
    expect(page).to have_selector("h1", text: "Step 1")
    page.within "#breadcrumbs" do
      expect(page.html).to include('<a href="/onboard">Onboard</a>')
    end
    page.within "#breadcrumbs .selected" do
      expect(page.html).to include('<a href="/onboard/step/1">Step 1</a>')
    end

    click_on "Save & Next" # POST
    expect(page).to have_selector("h1", text: "Step 2")
    page.within "#breadcrumbs .selected" do
      expect(page.html).to include('<a href="/onboard/step/2">Step 2</a>')
    end

    click_on "Save & Next" # PUT
    expect(page).to have_selector("h1", text: "Step 3")
    page.within "#breadcrumbs .selected" do
      expect(page.html).to include('<a href="/onboard/step/3">Step 3</a>')
    end

    click_on "Save & Next" # PATCH
    expect(page).to have_selector("h1", text: "Step 4")
    page.within '#breadcrumbs .selected' do
      expect(page.html).to include('<a href="/onboard/step/4">Step 4</a>')
    end

    click_on "Save & Next" # DELETE
    expect(page).to have_selector("h1", text: "Step 5")
    page.within "#breadcrumbs .selected" do
      expect(page.html).to include('<a href="/onboard/step/5">Step 5</a>')
    end

    click_on "Save & Next" # GET
    expect(page).to have_selector("h1", text: "Step 6")
    page.within "#breadcrumbs .selected" do
      expect(page.html).to include('<a href="/onboard/step/6">Step 6</a>')
    end
  end
end
