# encoding: utf-8

require 'spec_helper'

RSpec.describe 'setting configuration options' do
  it "contains 'selected' inside the breadcrumb markup" do
    visit posts_path
    within '#breadcrumbs' do
      expect(page).to have_selector('.selected')
    end
  end
end
