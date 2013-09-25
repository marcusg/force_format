require_relative "errors"

module ControllerAccess
  extend ActiveSupport::Concern

  module ClassMethods
    include ForceFormat::Errors
    TYPES = [:html, :js, :json, :pdf, :csv, :zip, :xml]

    def force_format_filter(opts={})
      forced_formats = opts[:for]
      unsupported = forced_formats - TYPES
      raise UnsupportedFormatsError.new("There is no support for #{unsupported} format") if unsupported.any?

      self.send(:before_filter, opts.slice(:only, :except, :if, :unless)) do |controller|
        format = controller.request.format
        unless forced_formats.include?(format.try(:to_sym))
          raise ActionController::RoutingError, "Format '#{format}' not supported for #{request.path.inspect}"
        end
      end
    end

  end
end