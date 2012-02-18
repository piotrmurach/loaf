require 'action_controller'
require 'loaf/configuration'
require 'loaf/railtie'
require 'loaf/filters'
require 'loaf/helpers'

module Loaf
  if defined? Rails::Railtie
    require 'loaf/railtie'
  else
    autoload :Filters, 'loaf/filters'
    autoload :Helpers, 'loaf/helpers'

    ::ActionController::Base.send :include, Loaf::Filters
    ::ActionController::Base.helper Loaf::Helpers
  end

  extend Configuration
end
