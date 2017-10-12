require 'action_view'

class DummyView < ActionView::Base
  module FakeRequest
    class Request
      attr_accessor :path, :fullpath
      def get?
        true
      end
    end
    def request
      @request ||= Request.new
    end
    def params
      @params ||= {}
    end
  end

  include FakeRequest
  include ActionView::Helpers::UrlHelper
  include Loaf::ViewExtensions

  attr_reader :_breadcrumbs

  routes = ActionDispatch::Routing::RouteSet.new
  routes.draw do
    get "/" => "foo#bar", :as => :home
    get "/posts" => "foo#posts"
    get "/posts/:title" => "foo#posts"
    get "/post/:id" => "foo#post", :as => :post
    get "/post/:title" => "foo#title"
  end

  include routes.url_helpers

  def set_path(path)
    request.path = path
    request.fullpath = path
  end
end
