require_relative "errors"

module ControllerAccess
  extend ActiveSupport::Concern
  FORCE_FORMAT_TYPES = [:html, :js, :json, :pdf, :csv, :zip, :xml]
  FORCE_FORMAT_DEFAULT_TYPES = [:html]

  module ClassMethods
    include ForceFormat::Errors

    def force_format_filter(opts={})
      send(:before_filter, :force_format_filter_method, opts.slice(:only, :except, :if, :unless, :for))
    end

    def skip_force_format_filter(opts={})
      send(:skip_before_filter, :force_format_filter_method, opts.slice(:only, :except, :if, :unless))
    end

  end

  private

  def force_format_filter_method
    force_formats = force_format_extract_options_from_filter_chain
    unsupported = force_formats - FORCE_FORMAT_TYPES
    raise UnsupportedFormatsError.new("There is no support for #{unsupported} format") if unsupported.any?
    format = request.format
    unless force_formats.include?(format.try(:to_sym))
      raise ActionController::RoutingError, "Format '#{format}' not supported for #{request.path.inspect}"
    end
  end

  def force_format_extract_options_from_filter_chain
    filter = self._process_action_callbacks.find { |f| f.filter == :force_format_filter_method }
    force_formats = filter.options[:for]
    force_formats.is_a?(Array) ? force_formats : (force_formats.is_a?(Symbol) ? [force_formats] : FORCE_FORMAT_DEFAULT_TYPES)
  end

end