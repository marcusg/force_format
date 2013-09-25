require_relative "errors"

module ControllerAccess
  extend ActiveSupport::Concern

  module ClassMethods
    include ForceFormat::Errors
    FORCE_FORMAT_TYPES = [:html, :js, :json, :pdf, :csv, :zip, :xml]
    FORCE_FORMAT_DEFAULT_TYPES = [:html]

    def force_format_filter(opts={})
      forced_formats = extract_options(opts)

      unsupported = forced_formats - FORCE_FORMAT_TYPES
      raise UnsupportedFormatsError.new("There is no support for #{unsupported} format") if unsupported.any?

      self.send(:before_filter, opts.slice(:only, :except, :if, :unless)) do |controller|
        return if controller.instance_variable_get("@_skip_force_format_filter") == true
        format = controller.request.format
        unless forced_formats.include?(format.try(:to_sym))
          raise ActionController::RoutingError, "Format '#{format}' not supported for #{request.path.inspect}"
        end
      end
    end

    def skip_force_format_filter(opts={})
      self.send(:prepend_before_filter, opts.slice(:only, :except, :if, :unless)) do |controller|
        controller.instance_variable_set("@_skip_force_format_filter", true)
      end
    end

    private

    def extract_options(opts)
      if opts[:for].is_a?(Array)
        opts[:for]
      elsif opts[:for].is_a?(Symbol)
        [opts[:for]]
      else
        FORCE_FORMAT_DEFAULT_TYPES
      end
    end

  end
end