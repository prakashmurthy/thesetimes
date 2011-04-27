require 'spec_helper'

describe Timeset do  
  describe "When creating a new record" do
    it "should generate a key" do
      t = Timeset.create
      t.short_url.length.should == 10
    end
  end
  
  describe "Given relations" do
    it "should have many sections" do
      t = Timeset.create
      t.sections.create :start => Time.now, :end => Time.now + 1.hour
      t.sections.length.should == 1
    end
  end
  
  describe "When cleaning times" do
    it "should change 8:60 into 9:00" do
      times = {:start => "8:60 AM"}
      times = Timeset.clean_times times
      times[:start].should == "9:00 AM"
    end
    
    it "should change 12:60 PM into 1:00 PM" do
      times = {:start => "12:60 PM"}
      times = Timeset.clean_times times
      times[:start].should == "1:00 PM"
    end
    
    it "should change from AM to PM" do
      times = {:start => "11:60 AM"}
      times = Timeset.clean_times times
      times[:start].should == "12:00 PM"
    end
  end
  
  describe "When creating time intervals" do
    before(:each) do
      @times = Timeset.time_intervals(5, 9)
    end
    
    it "should create an array of times" do
      @times.class.should == Array
    end
    
    it "should include the start time" do
      @times.should include("5:00 AM")
    end
    
    it "should include the end time" do
      @times.should include("9:00 PM")
    end
    
    it "should include noon" do
      @times.should include("12:00 PM")
    end
  end
end
