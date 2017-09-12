# encoding: utf-8

require_relative 'crumb'

module Loaf
  module ControllerExtensions
    # Module injection
    #
    # @api private
    def self.included(base)
      base.extend ClassMethods
      base.send :include, InstanceMethods
      base.send :helper_method, :_breadcrumbs
    end

    module ClassMethods
      # Add breacrumb to the trail in controller as class method
      #
      # @param [String]
      #
      # @api public
      def breadcrumb(name, url, options = {})
        normalizer = method(:_normalize_name)
        before_filter(options) do |instance|
          normalized_name = normalizer.call(name, instance)
          normalized_url  = normalizer.call(url, instance)
          instance.send(:breadcrumb, normalized_name, normalized_url, options)
        end
      end
      alias_method :add_breadcrumb, :breadcrumb

      private

      # @api private
      def _normalize_name(name, instance)
        case name
        when NilClass
        when Proc
          name.call(instance)
        else
          name
        end
      end
    end # ClassMethods

    module InstanceMethods
      # Add collection of nested breadcrumbs.
      # * <tt>collection</tt> - required collection of object for iteration
      # * <tt>field</tt> - required object attribute name
      #
      def add_breadcrumbs(collection, field, options = {})
        namespace = nil
        item_set = if _check_if_nested collection
           items = collection.pop
           namespace = collection
           items
        else
          collection
        end
        item_set.each do |item|
          add_breadcrumb item.send(field.to_sym), [ namespace, item ].flatten.compact
        end
      end

      # Add breadcrumb in controller as instance method
      #
      # @param [String] name
      #
      # @param [Object] url
      #
      # @api public
      def breadcrumb(name, url, options = {})
        _breadcrumbs << Loaf::Crumb.new(name, url, options)
      end
      alias_method :add_breadcrumb, :breadcrumb

      # Collection of breadcrumbs
      #
      # @api private
      def _breadcrumbs
        @_breadcrumbs ||= []
      end

      # Remove all current breadcrumbs
      #
      # @api public
      def clear_breadcrumbs
        _breadcrumbs.clear
      end

      private

      def _check_if_nested(collection)
        collection.last.is_a? Array
      end
    end # InstanceMethods
  end # ControllerExtensions
end # Loaf
