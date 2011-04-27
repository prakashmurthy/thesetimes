require 'spec_helper'

describe Section do
  describe "When creating a new section" do
    it "should be filled in" do
      valid_attributes = {
        :start => "7:00 AM",
        :end => "8:00 AM",
        :day => "sunday",
        :timeset_id => 1
      }
      
      s = Section.new valid_attributes
      s.should be_valid
    end
  end
  
  describe "When entering incorrect data" do
    before(:each) do
      @s = Section.new
    end
    
    it "should not be valid without a start time" do
      @s.errors_on(:start).should include("can't be blank")
    end
    
    it "should not be valid without an end time" do
      @s.errors_on(:end).should include("can't be blank")
    end
    
    it "should not be valid without a timeset id" do
      @s.errors_on(:timeset_id).should include("can't be blank")
    end
    
    it "should not be vaild without a day" do
      @s.errors_on(:day).should include("can't be blank")
    end
  end
  
  describe "When outputting the time range" do
    it "should be from start to end" do
      section = Section.create :start => "7:00 AM", :end => "8:00 AM", :day => "sunday", :timeset_id => 1
      
      section.time_range.should == "7:00 AM to 8:00 AM"
    end
  end
  
  describe "Given relations" do
    it "should belong to a timeset" do
      t = Timeset.create
      s = Section.create :timeset_id => t.id, :start => Time.now, :end => Time.now + 1.hour
      s.timeset.should == t
    end
  end
end
