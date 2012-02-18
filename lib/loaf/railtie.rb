# encoding: utf-8

require 'action_controller'
require 'action_view'

module Loaf
  if defined? Rails::Railtie
    class Railtie < Rails::Railtie
      initializer "loaf.extend_action_controller_base" do |app|
        ActiveSupport.on_load :action_controller do
          Loaf::Railtie.insert_controller
          Loaf::Railtie.insert_view
        end
      end
    end
  end

  class Railtie
    class << self
      def insert_view
        ActionController::Base.helper Loaf::ViewExtensions
      end
      def insert_controller
        ActionController::Base.send :include, Loaf::ControllerExtensions
      end
    end
  end # Railtie

end # Loaf
