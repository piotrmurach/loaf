# encoding: utf-8

require 'loaf/crumb_formatter'
require 'loaf/options_validator'

module Loaf
  module ViewExtensions
    include Loaf::CrumbFormatter
    include Loaf::OptionsValidator

    # Adds breadcrumbs inside view.
    #
    def breadcrumb(name, url, options={})
      _breadcrumbs.push Loaf::Crumb.new(name, url, options[:force])
    end
    alias :add_breadcrumb :breadcrumb

    # Renders breadcrumbs inside view.
    #
    def breadcrumbs(options={}, &block)
      #builder = Loaf::Builder.new(options)
      valid? options
      options = Loaf.config.merge(options)
      _breadcrumbs.each do |crumb|
        name = format_name crumb, options

        url = url_for _process_url_for(crumb.url)

        styles = (current_page?(url) || crumb.force) ? "#{options[:style_classes]}" : ''

        block.call(name, url, styles)
      end
    end

    private

    def _process_url_for(url)
      if url.is_a?(String) || url.is_a?(Symbol)
        return respond_to?(url) ? send(url) : url
      else
        return url
      end
    end

  end # ViewExtensions
end # Loaf
