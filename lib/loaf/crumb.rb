# encoding: utf-8

module Loaf
  # Basic crumb container
  class Crumb
    attr_reader :name

    attr_reader :url

    attr_reader :force

    def initialize(name, url, options = {})
      @name  = name
      @url   = url
      @force = options.fetch(:force) { false }
    end
  end
end # Loaf
