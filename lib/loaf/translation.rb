# frozen_string_literal: true

module Loaf
  module Translation
    extend self

    # Returns translation lookup
    def translation_scope
      "loaf.breadcrumbs"
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
    def find_title(title, options = {})
      options[:scope] ||= translation_scope
      options[:default] = Array(options[:default])
      options[:default] << title if options[:default].empty?
      I18n.t("#{title}", options)
    end
  end # Translation
end # Loaf
