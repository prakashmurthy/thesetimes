require 'spec_helper'

describe SectionsController do
  describe "When getting all of the sections for a timeset" do
    it "should include the correct section" do
      t = Timeset.create
      s = t.sections.create :start => "7:00 AM", :end => "8:00 AM", :day => "sunday"
      
      get :index, :key => t.short_url
      assigns(:sections).should include(s)
    end
  end
  
  describe "When deleting a section" do
    it "should be deleted" do
      s = Section.create :start => "7:00 AM", :end => "8:00 AM", :day => "sunday", :timeset_id => 1
      delete :destroy, :id => s.id
      Section.all.length.should == 0
    end
  end
end
