# encoding: utf-8

require 'loaf/configuration'
require 'loaf/errors'
require 'loaf/railtie'
require 'loaf/crumb'
require 'loaf/builder'
require 'loaf/translation'
require 'loaf/controller_extensions'
require 'loaf/view_extensions'
require 'loaf/crumb_formatter'
require 'loaf/options_validator'

module Loaf
  # Set global configuration
  #
  # @api public
  def self.configuration=(config)
    @configuration = config
  end

  # Get global configuration
  #
  # @api public
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Sets the Loaf configuration options. Best used by passing a block.
  #
  # Loaf.configure do |config|
  #   config.capitalize = true
  # end
  def self.configure
    yield configuration
  end

  if defined? Rails::Railtie
    require 'loaf/railtie'
  else
    autoload :ControllerExtensions, 'loaf/controller_extensions'
    autoload :Helpers, 'loaf/view_extensions'

    ::ActionController::Base.send :include, Loaf::ControllerExtensions
    ::ActionController::Base.helper Loaf::ViewExtensions
  end
end # Loaf
