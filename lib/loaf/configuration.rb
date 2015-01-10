# encoding: utf-8

module Loaf
  class Configuration
    VALID_ATTRIBUTES = [
      :locales_path,
      :style_classes,
      :crumb_length,
      :last_crumb_linked,
      :capitalize,
      :root
    ]

    attr_accessor(*VALID_ATTRIBUTES)

    DEFAULT_LOCALES_PATH = '/'

    DEFAULT_STYLE_CLASSES = 'selected'

    DEFAULT_CRUMB_LENGTH = 30

    DEFAULT_LAST_CRUMB_LINKED = false

    DEFAULT_CAPITALIZE = false

    DEFAULT_ROOT = true

    # Setup this configuration
    #
    # @api public
    def initialize
      VALID_ATTRIBUTES.each do |attr|
        send("#{attr}=", self.class.const_get("DEFAULT_#{attr.to_s.upcase}"))
      end
    end

    # Convert all properties into hash
    #
    # @return [Hash]
    #
    # @api public
    def to_hash
      VALID_ATTRIBUTES.reduce({}) { |acc, k| acc[k] = send(k); acc }
    end
  end # Configuration
end # Loaf
