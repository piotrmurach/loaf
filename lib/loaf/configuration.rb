module Loaf
  module Configuration

    VALID_ATTRIBUTES = [
      :locales_path,
      :style_classes,
      :crumb_length,
      :last_crumb_linked,
      :capitalize,
      :root
    ]

    attr_accessor *VALID_ATTRIBUTES

    DEFAULT_LOCALES_PATH = "/"

    DEFAULT_STYLE_CLASSES = 'selected'

    DEFAULT_CRUMB_LENGTH = 30

    DEFAULT_LAST_CRUMB_LINKED = false

    DEFAULT_CAPITALIZE = false

    DEFAULT_ROOT = true

    def configure
      yield self
    end

    def self.extended(base)
      base.setup(self)
    end

    def config
      VALID_ATTRIBUTES.inject({}) { |hash, k| hash[k] = send(k); hash }
    end

    def setup(parent)
      VALID_ATTRIBUTES.each do |attr|
        send("#{attr}=", parent.const_get("DEFAULT_#{attr.to_s.upcase}"))
      end
    end

  end # Configuration
end # Loaf
