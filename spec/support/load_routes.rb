RSpec.configure do |c|
  c.include Rails.application.routes.url_helpers,
    :example_group => {
      :file_path => /\bspec\/integration\//
    }
end
