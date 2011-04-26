class Timeset < ActiveRecord::Base
  before_save :generate_short_url
  has_many :sections
  
  def generate_short_url
    if self.new_record?
      self.short_url = Timeset.generate_key
    end
  end
  
  def self.generate_key
    key = ""
    5.times {key += (rand(26) + 65).chr}
    key
  end
  
  def self.time_intervals(early, late)
    (early..11).to_a.collect{|t| "#{t}:00 AM"} + ["12:00 PM"] + (1..late).to_a.collect{|t| "#{t}:00 PM"}
  end
end
