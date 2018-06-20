class Article < Struct.new(:id, :title); end

class CommentsController < ApplicationController

  breadcrumb lambda { |c| c.find_article(c.params[:post_id]).title },
             lambda { |c| c.post_comments_path(c.params[:post_id]) }

  breadcrumb -> { find_article(params[:post_id]).title + " No Controller" },
             -> { post_comments_path(params[:post_id], no_controller: true) }

  def index
  end

  def show
  end

  def find_article(id)
    ::Article.new(id, 'Post comments')
  end
end
