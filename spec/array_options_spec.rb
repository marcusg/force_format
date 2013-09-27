require 'spec_helper'


describe PagesController, :type => :controller do

  context "force_format_filter is used with [:html] for all actions" do

    controller do
      send "force_format_filter", :for => [:html]

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

  end

  context "force_format_filter is used with [:html, :js] for all actions" do

    controller do
      send "force_format_filter", :for => [:html, :js]

      def index
        render "with_html_js"
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

    it "should respond with 200 for js" do
      get "index", :format => :js
      response.code.should eq("200")
    end

    it "should respond with RoutingError for xml" do
      expect { get "index", :format => :xml }.to raise_error(ActionController::RoutingError)
    end

    it "should respond with RoutingError for json" do
      expect { get "index", :format => :json }.to raise_error(ActionController::RoutingError)
    end

  end



  context "force_format_filter is used with [:html, :js, :invalid] for all actions" do

    controller do
      send "force_format_filter", :for => [:html, :js, :invalid]

      def index
        render "with_html_js"
      end
    end

    it "should respond with RoutingError for html" do
      expect { get "index" }.to raise_error(UnsupportedFormatsError)
    end

    it "should respond with RoutingError for js" do
      expect { get "index", :format => :js }.to raise_error(UnsupportedFormatsError)
    end

    it "should respond with RoutingError for invalid" do
      expect { get "index", :format => :invalid }.to raise_error(UnsupportedFormatsError)
    end

    it "should respond with RoutingError for xml" do
      expect { get "index", :format => :xml }.to raise_error(UnsupportedFormatsError)
    end

    it "should respond with RoutingError for json" do
      expect { get "index", :format => :json }.to raise_error(UnsupportedFormatsError)
    end

  end

end