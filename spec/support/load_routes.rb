RSpec.configure do |c|
  c.include Rails.application.routes.url_helpers,
  :file_path => /\bspec\/integration\//
end
