# frozen_string_literal: true

module Loaf
  # Basic crumb container for internal use
  # @api private
  class Crumb
    attr_reader :name

    attr_reader :url

    attr_reader :match

    attr_reader :http_verbs

    def initialize(name, url, options = {})
      @name  = name || raise_name_error
      @url   = url || raise_url_error
      @match = options.fetch(:match, Loaf.configuration.match)
      @http_verbs = options.fetch(:http_verbs, Loaf.configuration.http_verbs)
      freeze
    end

    def raise_name_error
      raise ArgumentError, 'breadcrumb first argument, `name`, cannot be nil'
    end

    def raise_url_error
      raise ArgumentError, 'breadcrumb second argument, `url`, cannot be nil'
    end
  end # Crumb
end # Loaf
