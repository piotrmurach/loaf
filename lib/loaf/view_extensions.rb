# encoding: utf-8

require 'loaf/crumb_formatter'

module Loaf
  module ViewExtensions
    include Loaf::CrumbFormatter

    # Adds breadcrumbs in a view.
    #
    def add_breadcrumb(name, url)
      _breadcrumbs.push Loaf::Crumb.new(name, url)
    end

    # Renders breadcrumbs inside view.
    #
    def breadcrumbs(options={}, &block)
      #builder = Loaf::Builder.new(options)
      options = Loaf.config.merge(options)

      _breadcrumbs.each do |crumb|
        name = format_name crumb, options

        url = url_for _process_url_for(crumb.url)

        styles = current_page?(url) ? "#{options[:style_classes]}" : ''

        block.call(name, url, styles)
      end
    end

    private

    def _process_url_for(url)
      if url.is_a?(String) || url.is_a?(Symbol)
        return send url
      else
        return url
      end
    end

  end # ViewExtensions
end # Loaf
