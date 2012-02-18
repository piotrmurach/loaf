require 'loaf/configuration'
require 'loaf/railtie'
require 'loaf/crumb'
require 'loaf/builder'
require 'loaf/translation'
require 'loaf/controller_extensions'
require 'loaf/view_extensions'

module Loaf
  extend Configuration

  if defined? Rails::Railtie
    require 'loaf/railtie'
  else
    autoload :ControllerExtensions, 'loaf/controller_extensions'
    autoload :Helpers, 'loaf/view_extensions'

    ::ActionController::Base.send :include, Loaf::ControllerExtensions
    ::ActionController::Base.helper Loaf::ViewExtensions
  end
end # Loaf
