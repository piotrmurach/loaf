# encoding: utf-8

RSpec.describe "breadcrumbs trail" do
  before do
    include ActionView::TestCase::Behavior
  end

  it "shows root breadcrumb" do
    visit root_path

    within "#breadcrumbs .selected" do
      expect(page).to have_link(href: "/", text: "Home")
    end
  end

  it "inherits controller breadcrumb and adds index action breadcrumb" do
    visit posts_path

    within "#breadcrumbs" do
      expect(page).to have_link(href: "/", text: "Home")
    end
    within "#breadcrumbs .selected" do
      expect(page).to have_link(href: "/posts", text: "All Posts")
    end
  end

  it "filters out controller breadcrumb and adds new action breadcrumb" do
    visit new_post_path

    within "#breadcrumbs" do
      expect(page).to_not have_content("Home")
      expect(page).to have_content("New Post")
    end
  end

  it "adds breadcrumb in view with path variable" do
    visit post_path(1)

    within "#breadcrumbs .selected" do
      expect(page).to have_link(href: "/posts/1", text: "Show Post in view")
    end
  end

  it "is current when forced" do
    visit new_post_path

    expect(page.current_path).to eq(new_post_path)
    within "#breadcrumbs" do
      expect(page).to have_selector("li.selected", count: 2)
      expect(page).to have_link(href: "/posts", text: "All")
      expect(page).to have_link(href: "/posts/new", text: "New Post")
    end
  end

  it "allows for procs in name and url" do
    visit post_comments_path(1)

    within "#breadcrumbs .selected" do
      expect(page).to have_link(href: "/posts/1/comments", text: "Post comments")
    end
  end

  it "allows for procs in name and url without supplying the controller" do
    visit post_comments_path(1, no_controller: true)

    within "#breadcrumbs .selected" do
      expect(page).to have_link(
        href: "/posts/1/comments?no_controller=true",
        text: "Post comments No Controller"
      )
    end
  end

  it "match to Non-GET methods" do
    visit onboard_path

    expect(page).to have_selector("h1", text: "Onboard")
    within "#breadcrumbs" do
      expect(page).to have_content("Onboard")
    end

    click_link "Step 1" # GET
    expect(page).to have_selector("h1", text: "Step 1")
    within "#breadcrumbs" do
      expect(page).to have_link(href: "/onboard", text: "Onboard")
    end
    within "#breadcrumbs .selected" do
      expect(page).to have_link(href: "/onboard/step/1", text: "Step 1")
    end

    click_on "Save & Next" # POST
    expect(page).to have_selector("h1", text: "Step 2")
    within "#breadcrumbs .selected" do
      expect(page).to have_link(href: "/onboard/step/2", text: "Step 2")
    end

    click_on "Save & Next" # PUT
    expect(page).to have_selector("h1", text: "Step 3")
    within "#breadcrumbs .selected" do
      expect(page).to have_link(href: "/onboard/step/3", text: "Step 3")
    end

    if Rails.version >= "4.0.0"
      click_on "Save & Next" # PATCH
      expect(page).to have_selector("h1", text: "Step 4")
      within "#breadcrumbs .selected" do
        expect(page).to have_link(href: "/onboard/step/4", text: "Step 4")
      end
    end

    click_on "Save & Next" # DELETE
    expect(page).to have_selector("h1", text: "Step 5")
    within "#breadcrumbs .selected" do
      expect(page).to have_link(href: "/onboard/step/5", text: "Step 5")
    end

    click_on "Save & Next" # GET
    expect(page).to have_selector("h1", text: "Step 6")
    within "#breadcrumbs .selected" do
      expect(page).to have_link(href: "/onboard/step/6", text: "Step 6")
    end
  end
end
