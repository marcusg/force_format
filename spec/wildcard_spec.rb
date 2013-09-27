require 'spec_helper'

describe PagesController, :type => :controller do

  context "force_format_filter is used with a wildcard format and rewrite set" do

    controller do
      send "force_format_filter", :for => :html, :skip_wildcard => false

      def index
        render "with_html"
      end
    end

    it "should respond with 200 for html" do
      request.env["HTTP_ACCEPT"] = '*/*'
      get "index"
    end

  end

  context "force_format_filter is used with a wildcard format and rewrite set to false" do

    controller do
      send "force_format_filter", :for => :html, :skip_wildcard => true

      def index
        render "with_html"
      end
    end

    it "should respond with RoutingError for html" do
      expect do
        request.env["HTTP_ACCEPT"] = '*/*'
        get "index"
      end.to raise_error(ActionController::RoutingError)
    end

  end

end