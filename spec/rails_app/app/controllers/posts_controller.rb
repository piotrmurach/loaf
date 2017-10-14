class Post < Struct.new(:id); end

class PostsController < ApplicationController
  def index
    breadcrumb 'all_posts', posts_path
  end

  def show
    @post = ::Post.new(1)
  end

  def new
    breadcrumb 'All', :posts_path, match: :force
    breadcrumb 'New Post', new_post_path
  end

  def create
    render action: :new
  end
end
