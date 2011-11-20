require 'loaf/configuration'

module Loaf
  module Helpers

    class_eval do
      define_method :config do |options|
        Loaf.config
      end
    end

    # Adds breadcrumbs in a view
    def add_breadcrumb(name, url=nil)
      _breadcrumbs.push(name, url)
    end

    def breadcrumbs(options={}, &block)
      #builder = Loaf::Builder.new(options)
      options = config.merge(options)

      _breadcrumbs.each do |crumb|

        name = if crumb.name
          formatted = options[:capitalize] ? crumb.name.capitalize : crumb.name
          truncate(formatted, :length => options[:crumb_length])
        else
          '[name-error]'
        end

        url = url_for _process_url_for(crumb.url)

        styles = ( request.request_uri.split('?')[0] == url ? "#{options[:style_classes]}" : '' )

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

  end # Helpers
end # Loaf
