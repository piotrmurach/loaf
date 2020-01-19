require_relative 'loaf/configuration'
require_relative 'loaf/railtie'
require_relative 'loaf/version'

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
end # Loaf
