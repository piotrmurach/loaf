class PostsController < ApplicationController

  add_breadcrumb 'All Posts', :posts_path

  def index
  end

  def new
    add_breadcrumb 'New Post', 'new_post_path' 
  end

end
