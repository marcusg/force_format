require 'spec_helper'

describe PagesController, :type => :controller do

  context "force_format_filter is used with format specified more than once" do

    controller do
      send "force_format_filter", :for => {:index => [:js], :new => :json}

      def index
        render "with_js"
      end

      def new
        render "with_json"
      end
    end

    it "should respond with 200 for js" do
      get "index", :format => :js
      response.code.should eq("200")
    end

    it "should respond with 200 for json" do
      get "new", :format => :json
      response.code.should eq("200")
    end

    it "should respond with RoutingError for html" do
      expect { get "index", :format => :html }.to raise_error(UnknownFormat)
    end

    it "should respond with RoutingError for html" do
      expect { get "new", :format => :html }.to raise_error(UnknownFormat)
    end

  end

  context "force_format_filter is used with format specified more than once but used default" do

    controller do
      send "force_format_filter", :for => {:index => :js, :default => [:json]}

      def index
        render "with_js"
      end

      def new
        render "with_json"
      end
    end

    it "should respond with 200 for js" do
      get "index", :format => :js
      response.code.should eq("200")
    end

    it "should respond with 200 for json" do
      get "new", :format => :json
      response.code.should eq("200")
    end

    it "should respond with RoutingError for html" do
      expect { get "index", :format => :html }.to raise_error(UnknownFormat)
    end

    it "should respond with RoutingError for html" do
      expect { get "new", :format => :html }.to raise_error(UnknownFormat)
    end

  end


  context "force_format_filter is used with unsupported format" do

    controller do
      send "force_format_filter", :for => {:index => :what}

      def index
        render "with_js"
      end
    end

    it "should respond with UnsupportedFormat for html" do
      expect { get "index", :format => :html }.to raise_error(UnsupportedFormat)
    end

  end

  context "force_format_filter is used with unsupported format" do

    controller do
      send "force_format_filter", :for => {:index => :what}

      def index
        render "with_js"
      end
    end

    it "should respond with UnsupportedFormat for html" do
      expect { get "index", :format => :html }.to raise_error(UnsupportedFormat)
    end

  end
end