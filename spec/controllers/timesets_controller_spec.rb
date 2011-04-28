require 'spec_helper'

describe TimesetsController do
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
  
  describe "A post request to the lock action" do
    it "should lock the timeset when given a password" do
      @t = Timeset.create
      post :lock, :key => @t.short_url, :pass => "abcd"
      @t.reload
      @t.should be_locked
    end
    
    it "should not lock the timeset if the password is blank" do
      @t = Timeset.create
      post :lock, :key => @t.short_url, :pass => ""
      @t.reload
      @t.should_not be_locked
    end
  end
  
  describe "A post request to the unlock action" do
    before(:each) do
      @t = Timeset.create
      @t.lock "password"
    end
    
    it "should unlock the timeset when given the correct password" do
      post :unlock, :key => @t.short_url, :pass => "password"
      @t.reload
      @t.should_not be_locked
    end
    
    it "should not unlock the timeset if the password is blank" do
      post :unlock, :key => @t.short_url, :pass => ""
      @t.reload
      @t.should be_locked
    end
  end
end
