# encoding: utf-8

require 'loaf/errors'

module Loaf
  module OptionsValidator
    def valid?(options)
      valid_options = Loaf::Configuration::VALID_ATTRIBUTES
      options.each_key do |key|
        if !valid_options.include?(key)
          raise Loaf::InvalidOptions.new(key, valid_options)
        end
      end
      true
    end
  end # OptionsValidator
end # Loaf
