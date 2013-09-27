require 'spec_helper'

describe PagesController, :type => :controller do

  context "force_format_filter is not used (rails defaults)" do

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
end