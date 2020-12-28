# encoding: utf-8

RSpec.describe 'setting configuration options' do
  it "contains 'selected' inside the breadcrumb markup" do
    visit posts_path
    page.within '#breadcrumbs' do
      expect(page).to have_selector('.selected')
    end
  end
end
