# encoding: utf-8
# frozen_string_literal: true

module Loaf
  # Basic crumb container
  class Crumb
    attr_reader :name

    attr_reader :url

    attr_reader :match

    def initialize(name, url, options = {})
      @name  = name
      @url   = url
      @match = options.fetch(:match) { :inclusive }
    end
  end
end # Loaf
