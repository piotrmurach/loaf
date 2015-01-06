# encoding: utf-8

module Loaf
  module Translation
    extend self

    # Returns translation lookup
    def i18n_scope
      :breadcrumbs
    end

    # Translate breadcrumb title
    #
    # @param [String] :title
    # @param [Hash] options
    # @option options [String] :scope
    #   The translation scope
    # @option options [String] :default
    #   The default translation
    #
    # @api public
    def breadcrumb_title(title, options = {})
      defaults  = []
      defaults << :"#{i18n_scope}.#{title}"
      defaults << options.delete(:default) if options[:default]

      options.reverse_merge! count: 1, default: defaults
      I18n.t(title, options)
    end
  end # Translation
end # Loaf
