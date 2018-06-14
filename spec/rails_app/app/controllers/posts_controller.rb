class Post < Struct.new(:id); end

class PostsController < ApplicationController
  before_filter :load_post

  breadcrumb ->(_) { @special_post.id.to_s },
             ->(_) { post_path(@special_post.id) }, only: [:show]

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

  private

  def load_post
    @special_post = ::Post.new(0xDEADBEEF)
  end
end
