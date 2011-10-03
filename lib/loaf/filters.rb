module Loaf
  module Filters
    
    Crumb = Struct.new(:name, :url, :styles)

    module ClassMethods
      
      def add_breadcrumb(name, url, options = {})
        before_filter(options) do |instance|
          instance.send(:add_breadcrumb, _normalize_name(name), url)
        end
      end

      private
      
      def _normalize_name(name=nil)
        case name 
        when NilClass
        when Proc
          name.call 
        when Symbol
          name.to_s
        else
          name
        end
      end
    end

    module InstanceMethods

      # Add collection of nested breadcrumbs.
      def add_breadcrumbs(collection=[], options={})
        return nil unless collection.is_a? Array

        #TODO see how best handle population
      end
      
      def add_breadcrumb(name, url)
        _breadcrumbs << Crumb.new(name, url)
      end

      def _breadcrumbs
        @_breadcrumbs ||= []
      end

      def clear_crumbs
        _breadcrumbs.clear
      end
    end # InstanceMethods

    def self.included(base)
      base.extend ClassMethods
      base.send :include, InstanceMethods
      base.send :helper_method, :_breadcrumbs
    end

  end # Filters
end # Loaf
