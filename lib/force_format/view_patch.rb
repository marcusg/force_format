module ViewPatch
  class ActionView::LookupContext
    def formats=(values)
      if values
        values.concat(default_formats) if values.delete "*/*"
        values << :html if values.empty?
      end
      super(values)
    end
  end
end
