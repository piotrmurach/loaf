# encoding: utf-8

require_relative 'crumb_formatter'
require_relative 'options_validator'

module Loaf
  # A mixin to define view extensions
  module ViewExtensions
    include Loaf::CrumbFormatter
    include Loaf::OptionsValidator

    def initialize(*)
      @_breadcrumbs ||= []
      super
    end

    # Checks to see if any breadcrumbs have been added
    #
    # @return [Boolean]
    #
    # @api public
    def breadcrumbs?
      _breadcrumbs.present?
    end

    # Adds breadcrumbs inside view.
    #
    # @param [String] name
    #   the breadcrumb name
    # @param [Object] url
    #   the breadcrumb url
    # @param [Hash] options
    #   the breadcrumb options
    #
    # @api public
    def breadcrumb(name, url, options = {})
      _breadcrumbs << Loaf::Crumb.new(name, url, options)
    end
    alias add_breadcrumb breadcrumb

    # Renders breadcrumbs inside view.
    #
    # @param [Hash] options
    #
    # @api public
    def breadcrumbs(options = {})
      return enum_for(:breadcrumbs) unless block_given?

      valid?(options)
      options = Loaf.configuration.to_hash.merge(options)
      _breadcrumbs.each do |crumb|
        name = format_name(crumb.name, options)
        path = url_for(_expand_url(crumb.url))
        styles = ''
        if current_page?(path) || crumb.force
          styles << "#{options[:style_classes]}"
        end
        yield(name, path, styles)
      end
    end

    private

    # Expand url in the current context of the view
    #
    # @api private
    def _expand_url(url)
      case url
      when String, Symbol
        respond_to?(url) ? send(url) : url
      when Proc
        url.call(self)
      else
        url
      end
    end
  end # ViewExtensions
end # Loaf
