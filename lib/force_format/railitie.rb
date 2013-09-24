require_relative "controller_access"

module ForceFormat

  class Railtie < Rails::Railtie

    initializer "force_format.initialize" do
      ActiveSupport.on_load :action_controller do
        include ControllerAccess
      end
    end

  end

end