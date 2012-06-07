require 'spec_helper'

describe 'setting configuration options' do

  context 'setting default css style for current crumb' do
    it "contains 'selected' inside the breadcrumb markup" do
      visit posts_path
      within '#breadcrumbs' do
        page.should have_selector('.selected')
      end
    end
  end
end
