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

        name = crumb.name ? truncate(crumb.name.upcase, :length => options[:crumb_length]) : ''
        url  = send(crumb.url)
        styles = ( request.request_uri.split('?')[0] == url ? "#{options[:style_classes]}" : '' )

        block.call(name, url, styles)
      end
    end

  end # Helpers
end # Loaf
