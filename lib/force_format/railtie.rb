require_relative "controller"
require_relative "view"

module ForceFormat

  class Railtie < Rails::Railtie

    initializer "force_format.controller" do
      ActiveSupport.on_load :action_controller do
        include Controller
      end
    end

    initializer "force_format.view" do
      ActiveSupport.on_load :action_view do
        include View
      end
    end

  end

end