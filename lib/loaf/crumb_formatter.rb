module Loaf
  module CrumbFormatter

    def format_name(crumb, options={})
      if !crumb.name.blank?
        formatted = crumb.name
        formatted = crumb.name.capitalize if options[:capitalize]
        formatted = if options[:crumb_length]
          truncate(formatted, :length => options[:crumb_length])
        else
          formatted
        end
        formatted
      else
        '[name-error]'
      end
    end

  end # CrumbFormatter
end # Loaf
