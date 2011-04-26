require 'spec_helper'

describe TimesetController do
  describe "A get request to the view action" do
    it "should render the view template" do
      get :view
      response.should render_template(:view)
    end
    
    it "should create a new record if not given a key" do
      get :view
      assigns(:timeset).should_not be_nil
    end
    
    it "should find a record if given a key" do
      t = Timeset.create
      get :view, :key => t.short_url
      assigns(:timeset).should == t
    end
    
    describe "When the short url does not resolve" do
      it "should redirect to the root url" do
        get :view, :key => "ABCDE"
        response.should redirect_to(root_url)
      end
      
      it "should set the alert" do
        get :view, :key => "ABCDE"
        flash[:alert].should_not be_empty
      end
    end
  end
end
