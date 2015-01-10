# encoding: utf-8

require 'loaf/crumb_formatter'
require 'loaf/options_validator'

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
    alias_method :add_breadcrumb, :breadcrumb

    # Renders breadcrumbs inside view.
    #
    # @param [Hash] options
    #
    # @api public
    def breadcrumbs(options = {}, &block)
      # builder = Loaf::Builder.new(options)
      return enum_for(:breadcrumbs) unless block_given?
      valid?(options)
      options = Loaf.configuration.to_hash.merge(options)
      _breadcrumbs.each do |crumb|
        name   = format_name(crumb.name, options)
        url    = url_for(_process_url_for(crumb.url))
        styles = ''
        if current_page?(url) || crumb.force
          styles << "#{options[:style_classes]}"
        end
        block.call(name, url, styles)
      end
    end

    private

    # @api private
    def _process_url_for(url)
      if url.is_a?(String) || url.is_a?(Symbol)
        return respond_to?(url) ? send(url) : url
      else
        return url
      end
    end
  end # ViewExtensions
end # Loaf
