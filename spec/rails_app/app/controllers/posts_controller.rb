class PostsController < ApplicationController
  add_breadcrumb 'Home', 'root_path'
  add_breadcrumb 'All Posts', :posts_path

  def index
  end

  def new
    add_breadcrumb 'New Post', 'new_post_path'
  end

  def create
    add_breadcrumb 'New Post', 'new_post_path', :force => true
    render :action => :new
  end
end
