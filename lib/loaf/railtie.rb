module Loaf

  if defined? Rails::Railtie
    class Railtie < Rails::Railtie
      initializer "loaf.extend_action_controller_base" do |app|
        ActiveSupport.on_load(:action_controller) do
          Loaf::Railtie.insert
        end
      end
    end
  end

  class Railtie
    def self.insert
      ActionController::Base.send :include, Loaf::Filters 
    end
  end # Railtie

end # Loaf
