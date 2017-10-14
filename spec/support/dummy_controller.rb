class DummyController < ActionController::Base
  def self.before_filter(options, &block)
    yield self.new
  end
  class << self
    alias before_action before_filter
  end
  include Loaf::ControllerExtensions
end
