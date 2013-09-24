module ControllerAccess
  extend ActiveSupport::Concern

  module ClassMethods

    def force_format_filter(opts={})
      opts.reverse_merge! :for => [:html]

      self.send(:before_filter, opts.slice(:only, :except, :if, :unless)) do |controller|
        old_format = controller.request.format
        unless old_format == Mime::HTML
          # controller.request.format = Mime::HTML
          raise ActionController::RoutingError, "Format '#{old_format.to_sym}' not supported for #{request.path.inspect}"
        end
      end
    end

  end

end