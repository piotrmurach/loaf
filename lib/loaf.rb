require 'action_controller'

module Loaf
  if defined? Rails::Railtie
    require 'loaf/railtie'
  else
    autoload :Filters, 'loaf/filters'
    autoload :Helpers, 'loaf/helpers'

    ::ActionController::Base.send :include, Loaf::Filters
    ::ActionController::Base.helper Loaf::Helpers
  end
end
