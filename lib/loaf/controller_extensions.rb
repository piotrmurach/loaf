# frozen_string_literal: true

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
        send(_filter_name, options) do |instance|
          normalized_name = normalizer.call(name, instance)
          normalized_url  = normalizer.call(url, instance)
          instance.send(:breadcrumb, normalized_name, normalized_url, options)
        end
      end
      alias add_breadcrumb breadcrumb

      # Provide a scope to add multiple breadcrumbs to the trail in controller as class method
      #
      # @api public
      def breadcrumbs(options = {}, &block)
        send(_filter_name, options) do |instance|
          instance.instance_exec(&block)
        end
      end

      private

      # Choose available filter name
      #
      # @api private
      def _filter_name
        respond_to?(:before_action) ? :before_action : :before_filter
      end

      # Convert breadcrumb name to string
      #
      # @return [String]
      #
      # @api private
      def _normalize_name(name, instance)
        case name
        when NilClass
        when Proc
          if name.arity == 1
            instance.instance_exec(instance, &name)
          else
            instance.instance_exec(&name)
          end
        else
          name
        end
      end
    end # ClassMethods

    module InstanceMethods
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
      alias add_breadcrumb breadcrumb

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
    end # InstanceMethods
  end # ControllerExtensions
end # Loaf
