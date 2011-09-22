module Loaf
  if defined? Rails::Railtie
    require 'loaf/railtie'
  else
    require 'loaf/filters'
    require 'loaf/helpers'
    ActionController::Base.send :include, Loaf::Filters
    ActionController::Base.helper Loaf::Helpers
  end
end
