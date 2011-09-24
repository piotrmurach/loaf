module Loaf
  module Helpers
    
    def breadcrumbs(options={}, &block)
      #builder = Loaf::Builder.new(options)

      @crumbs.each do |crumb|
        
        name = crumb.name ? truncate(crumb.name.upcase, :length => 30) : ''
        url  = eval(crumb.url)
        styles = ( request.request_uri.split('?')[0] == url ? 'selected' : '' )
       
        block.call(name, url, styles)
      end
    end
  end # Helpers
end # Loaf
