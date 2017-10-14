# encoding: utf-8
# frozen_string_literal: true

require_relative 'translation'

module Loaf
  # A mixin for formatting crumb name
  module CrumbFormatter
    # @param [String] name
    #   the name to format
    #
    # @api public
    def format_name(name, options = {})
      return name if name.nil? || name.empty?

      formatted = name.to_s.dup
      formatted = Loaf::Translation.find_title(formatted)
      formatted = formatted.capitalize if options[:capitalize]
      if options[:crumb_length]
        formatted = truncate(formatted, length: options[:crumb_length])
      end
      formatted
    end
  end # CrumbFormatter
end # Loaf
