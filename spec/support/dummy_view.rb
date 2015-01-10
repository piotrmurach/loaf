class DummyView < ActionView::Base
  include Loaf::ViewExtensions
  attr_reader :_breadcrumbs

  def url_for(*); end
  def current_page?(*); end
end
