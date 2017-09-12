# encoding: utf-8

module Loaf #:nodoc:
  # Default Loaf error for all custom errors.
  #
  class LoafError < StandardError
    BASE_KEY = "loaf.errors"

    def error_message(key, attributes)
      translate(key, attributes)
    end

    def translate(key, options)
      ::I18n.translate("#{BASE_KEY}.#{key}", { :locale => :en }.merge(options))
    end
  end

  # Raised when invalid options are passed to breadcrumbs view renderer.
  #  InvalidOptions.new :name, :crumber, [:crumb]
  #
  class InvalidOptions < LoafError
    def initialize(invalid, valid)
      super(
        error_message("invalid_options",
          { :invalid => invalid, :valid => valid.join(', ') }
        )
      )
    end
  end
end # Loaf
