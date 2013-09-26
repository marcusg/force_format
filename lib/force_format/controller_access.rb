require_relative "errors"

module ControllerAccess
  extend ActiveSupport::Concern
  FORCE_FORMAT_TYPES = [:html, :js, :json, :pdf, :csv, :zip, :xml]
  FORCE_FORMAT_DEFAULT_TYPES = [:html]
  FORCE_FORMAT_EXCEPTION = lambda { |o| raise(ActionController::RoutingError, o) }

  module ClassMethods
    include ForceFormat::Errors

    def force_format_filter(opts={})
      send(:before_filter, :force_format_filter_method, opts.slice(:only, :except, :if, :unless, :for, :exception))
    end

    def skip_force_format_filter(opts={})
      send(:skip_before_filter, :force_format_filter_method, opts.slice(:only, :except, :if, :unless))
    end

  end

  private

  def force_format_filter_method
    force_formats = force_format_extract_formats
    return unless force_formats
    unsupported = force_formats - FORCE_FORMAT_TYPES
    raise UnsupportedFormatsError.new("There is no support for #{unsupported} format") if unsupported.any?
    format = request.format
    unless force_formats.include?(format.try(:to_sym))
      force_format_extract_exception.call("Format '#{format}' not supported for #{request.path.inspect}")
    end
  end

  def force_format_load_filter_chain
    filter = self._process_action_callbacks.find { |f| f.filter == :force_format_filter_method }
  end

  def force_format_extract_formats
    force_formats = force_format_load_filter_chain.options[:for]

    if force_formats.is_a? (Array || Symbol)
      [*force_formats]
    elsif force_formats.is_a? Hash
      if force_formats[self.action_name.to_sym]
        [*force_formats[self.action_name.to_sym]]
      else
        force_formats[:default] ? [*force_formats[:default]] : nil
      end
    else
      FORCE_FORMAT_DEFAULT_TYPES
    end
  end

  def force_format_extract_exception
    force_format_load_filter_chain.options[:exception] || FORCE_FORMAT_EXCEPTION
  end

end