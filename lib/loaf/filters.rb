module Loaf
  module Filters
    
    Crumb = Struct.new(:name, :url, :styles)

    module ClassMethods
      def add_breadcrumb(name, url, options = {})
        before_filter options do |instance|
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
      
      def add_breadcrumb(name, url)
        crumbs << Crumb.new(name, url)
      end

      def crumbs
        @crumbs ||= []
      end

      def clear_crumbs
        crumbs.clear
      end
    end # InstanceMethods

    def self.included(base)
      base.extend ClassMethods
      base.send :include, InstanceMethods
    end

  end # Filters
end # Loaf
