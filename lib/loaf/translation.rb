module Loaf
  module Translation
    extend self

    # Returns translation lookup
    def i18n_scope
      :breadcrumbs
    end

    # Accepts <tt>:scope</tt> parameter.
    def breadcrumb_title(title, options={})
      defaults  = []
      parts     = title.to_s.split('.', 2)
      actions   = parts.pop
      namespace = parts.pop

      defaults << :"#{self.i18n_scope}.#{title}"
      defaults << options.delete(:default) if options[:default]

      options.reverse_merge! :count => 1, :default => defaults
      I18n.t(title, options)
    end
  end # Translation
end # Loaf
