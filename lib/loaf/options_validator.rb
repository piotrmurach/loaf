# encoding: utf-8

require 'loaf/errors'

module Loaf
  # A mixin to validate configuration options
  module OptionsValidator
    # Check if options are valid or not
    #
    # @param [Hash] options
    #
    # @return [Boolean]
    #
    # @api public
    def valid?(options)
      valid_options = Loaf::Configuration::VALID_ATTRIBUTES
      options.each_key do |key|
        unless valid_options.include?(key)
          fail Loaf::InvalidOptions.new(key, valid_options)
        end
      end
      true
    end
  end # OptionsValidator
end # Loaf
