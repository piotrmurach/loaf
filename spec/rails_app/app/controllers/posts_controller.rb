class Post < Struct.new(:id); end

class PostsController < ApplicationController

  breadcrumb 'Home', :root_path, only: :index

  def index
    breadcrumb 'all_posts', posts_path
  end

  def show
    @post = ::Post.new(1)
  end

  def new
    breadcrumb 'New Post', new_post_path
  end

  def create
    breadcrumb 'New Post', new_post_path, force: true
    render action: :new
  end
end
