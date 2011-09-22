module Loaf
  if defined? Rails::Railtie
    require 'loaf/railtie'
  else
    require 'loaf/filters'
    ActionController::Base.send :include, Loaf::Filters
  end
end
