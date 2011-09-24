module Loaf
  class Builder

    attr_accessor :crumbs

    def initialize(options = {})

      @params = default_options.merge(options)

      set_breadcrumbs

      build @params
    end

  private

    def set_breadcrumbs(breadcrumbs)
      @params[:breadcrumbs] = breadcrumbs
    end

    def build
      @params.each_pair do |option, value|

      end
    end

    def default_options
      { 
        :breadcrumbs => [],
        :delimiter => " &raquo ",
        :style_class => 'selected',
        :crumb_length => '30',
        :last_crumb_linked => false
      }
    end

  end # Builder
end # Loaf
