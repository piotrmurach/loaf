class ApplicationController < ActionController::Base
  protect_from_forgery

  breadcrumb 'Home', :root_path, only: :index
end
