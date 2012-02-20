require 'spec_helper'

describe "crumbs routing" do
  include ActionView::TestCase::Behavior

  context 'setting home breadcrumb' do
    it 'should inherit crumb for the root path' do
      visit root_path
      within '#breadcrumbs' do
        page.should have_content("Home")
      end
    end
  end

  context 'inheriting breadcrumbs setup' do
    it "should inherit root crumb for index action posts#index" do
      visit posts_path
      within '#breadcrumbs' do
        page.should have_content 'Home'
        page.should have_content 'All Posts'
        page.should_not have_content 'New Post'
      end
    end

    it 'should inherit and add new action specific breadcrumb' do
      visit new_post_path
      within '#breadcrumbs' do
        page.should have_content 'All Posts'
        page.should have_content 'New Post'
      end
    end
  end

  context 'adding breadcrumbs within view' do
    it 'should append view specified breadcrumb' do
      visit posts_path
      within '#breadcrumbs' do
        page.should have_content 'All Posts'
        page.should have_content 'View Post'
      end
    end
  end
end
