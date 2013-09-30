require 'spec_helper'

describe PagesController, :"rails-3.2" => true, :type => :controller do

  context "force_format_filter is not used (rails defaults with respond_to block for html and js)" do

    controller do
      def index
        respond_to do |format|
          format.html
          format.js { render "with_js" }
        end
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

    it "should respond with 406 for xml" do
      get "index", :format => :xml
      response.code.should eq("406")
    end

    it "should respond with 406 for json" do
      get "index", :format => :json
      response.code.should eq("406")
    end

    it "should respond with 406 for invalid" do
      get "index", :format => :invalid
      response.code.should eq("406")
    end

  end

  context "force_format_filter is not used (rails defaults with respond_to in controller for html and js)" do

    controller do
      respond_to :html

      def index
        respond_with []
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

    it "should respond with 406 for js" do
      get "index", :format => :js
      response.code.should eq("406")
    end

    it "should respond with 406 for xml" do
      get "index", :format => :xml
      response.code.should eq("406")
    end

    it "should respond with 406 for json" do
      get "index", :format => :json
      response.code.should eq("406")
    end

    it "should respond with 406 for invalid" do
      get "index", :format => :invalid
      response.code.should eq("406")
    end

  end


end