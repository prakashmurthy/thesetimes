require 'spec_helper'

describe Section do
  describe "When creating a new section" do
    it "should be filled in" do
      valid_attributes = {
        :start => Time.now,
        :end => Time.now + 1.hour,
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
  end
  
  describe "Given relations" do
    it "should belong to a timeset" do
      t = Timeset.create
      s = Section.create :timeset_id => t.id, :start => Time.now, :end => Time.now + 1.hour
      s.timeset.should == t
    end
  end
end
