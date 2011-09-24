require 'spec_helper'

describe "crumbs routing" do

  it "should have no breadcrumbs if none added" do
    pending  
  end

  it "should have only one crumb when visiting posts#index" do
    pending
  end

  it "displays the link with a name for the crumb in posts#index" do
    visit posts_path
    render
    rendered.should contain('Posts')
  end

  it "should have two crumbs when visiting posts#new" do
    pending 
  end
end
