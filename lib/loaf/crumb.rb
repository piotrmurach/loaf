# frozen_string_literal: true

module Loaf
  # Basic crumb container
  class Crumb
    attr_reader :name

    attr_reader :url

    attr_reader :match

    def initialize(name, url, options = {})
      raise ArgumentError, "first argument, `name`, cannot be nil" if name.nil?
      raise ArgumentError, "second argument, `url`, cannot be nil" if url.nil?

      @name  = name
      @url   = url
      @match = options.delete(:match) { :inclusive }
      freeze
    end
  end # Crumb
end # Loaf
