require 'spec_helper'

describe PagesController, :type => :controller do

  context "force_format_filter is used with a custom exception" do

    controller do
      send "force_format_filter", :for => [:js], :exception => lambda { |o| raise(ActiveRecord::RecordNotFound, o) }

      def index
        render "with_js"
      end
    end

    it "should respond with RecordNotFound for html" do
      expect { get "index", :format => :html }.to raise_error(ActiveRecord::RecordNotFound)
    end

  end

  context "force_format_filter is used with a custom exception but without raising an exception" do

    controller do
      send "force_format_filter", :for => [:js], :exception => lambda { |o| Rails.logger.info(o) }

      def index
        render "with_js"
      end
    end

    it "should respond with MissingTemplate for html" do
      expect { get "index", :format => :html }.to raise_error(ActionView::MissingTemplate)
    end

  end
end