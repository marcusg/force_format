require 'spec_helper'

describe PagesController, :type => :controller do

  context "force_format_filter is not used but skip_format_filter specified for all actions" do

    controller do
      send "skip_force_format_filter"

      def index
      end
    end

    it "should respond with 200 for html" do
      get "index"
      response.code.should eq("200")
    end

    it "should respond with 200 for html" do
      get "index", :format => :html
      response.code.should eq("200")
    end

    it "should respond with MissingTemplate for js" do
      expect { get "index", :format => :js }.to raise_error(ActionView::MissingTemplate)
    end

    it "should respond with MissingTemplate for xml" do
      expect { get "index", :format => :xml }.to raise_error(ActionView::MissingTemplate)
    end

    it "should respond with MissingTemplate for json" do
      expect { get "index", :format => :json }.to raise_error(ActionView::MissingTemplate)
    end

  end

  context "force_format_filter is used with no format specified for :index actions" do

    controller do
      send "force_format_filter", :only => :index
      send "skip_force_format_filter", :only => :skipped

      def new
        render "with_html"
      end

      def index
        render "with_html"
      end
    end

    it "should respond with 200 for html" do
      get "index"
      response.code.should eq("200")
    end

    it "should respond with 200 for html" do
      get "index", :format => :html
      response.code.should eq("200")
    end

    it "should respond with RoutingError for js" do
      expect { get "index", :format => :js }.to raise_error(ActionController::RoutingError)
    end

    it "should respond with RoutingError for xml" do
      expect { get "index", :format => :xml }.to raise_error(ActionController::RoutingError)
    end

    it "should respond with RoutingError for json" do
      expect { get "index", :format => :json }.to raise_error(ActionController::RoutingError)
    end


    it "should respond with 200 for html" do
      get "new"
      response.code.should eq("200")
    end

    it "should respond with 200 for html" do
      get "new", :format => :html
      response.code.should eq("200")
    end

    it "should respond with MissingTemplate for js" do
      expect { get "new", :format => :js }.to raise_error(ActionView::MissingTemplate)
    end

    it "should respond with MissingTemplate for xml" do
      expect { get "new", :format => :xml }.to raise_error(ActionView::MissingTemplate)
    end

    it "should respond with MissingTemplate for json" do
      expect { get "new", :format => :json }.to raise_error(ActionView::MissingTemplate)
    end

  end
end