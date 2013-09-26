require 'spec_helper'

describe PagesController, :type => :controller do

  context "force_format_filter is not used" do

    controller do
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


  context "force_format_filter is used with no format specified for all actions" do

    controller do
      send "force_format_filter"

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


  context "force_format_filter is used with skip_format_filter specified for all actions" do

    controller do
      send "force_format_filter"
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



  context "force_format_filter is used with skip_format_filter specified for all actions" do

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



  context "force_format_filter is used with no format specified for all actions" do

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
      expect { get "index", :format => :html }.to raise_error(ActionController::RoutingError)
    end

    it "should respond with RoutingError for html" do
      expect { get "new", :format => :html }.to raise_error(ActionController::RoutingError)
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
      expect { get "index", :format => :html }.to raise_error(ActionController::RoutingError)
    end

    it "should respond with RoutingError for html" do
      expect { get "new", :format => :html }.to raise_error(ActionController::RoutingError)
    end

  end


  context "force_format_filter is used with unsupported format" do

    controller do
      send "force_format_filter", :for => {:index => :what}

      def index
        render "with_js"
      end
    end

    it "should respond with RoutingError for html" do
      expect { get "index", :format => :html }.to raise_error(UnsupportedFormatsError)
    end

  end

  context "force_format_filter is used with unsupported format" do

    controller do
      send "force_format_filter", :for => {:index => :what}

      def index
        render "with_js"
      end
    end

    it "should respond with RoutingError for html" do
      expect { get "index", :format => :html }.to raise_error(UnsupportedFormatsError)
    end

  end

  context "force_format_filter is used with a custom exception" do

    controller do
      send "force_format_filter", :for => [:js], :exception => lambda { |o| raise(ActiveRecord::RecordNotFound, o) }

      def index
        render "with_js"
      end
    end

    it "should respond with RoutingError for html" do
      expect { get "index", :format => :html }.to raise_error(ActiveRecord::RecordNotFound)
    end

  end
end