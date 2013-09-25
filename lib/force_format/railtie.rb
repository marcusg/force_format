require_relative "controller_access"
require_relative "view_patch"

module ForceFormat

  class Railtie < Rails::Railtie

    initializer "force_format.controller" do
      ActiveSupport.on_load :action_controller do
        include ControllerAccess
      end
    end

    initializer "force_format.view" do
      ActiveSupport.on_load :action_view do
        include ViewPatch
      end
    end

  end

end