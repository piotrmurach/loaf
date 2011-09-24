class PostsController < ApplicationController
  
  add_breadcrumb 'Posts', 'posts_path'

  def index
  end

  def new
    add_breadcrumb 'New', 'new_post_path' 
  end

end
