class ApplicationController < ActionController::Base
  protect_from_forgery

  add_breadcrumb 'Home', 'root_path'
end
