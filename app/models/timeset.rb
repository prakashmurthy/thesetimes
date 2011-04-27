class Timeset < ActiveRecord::Base
  before_create :generate_short_url
  has_many :sections
  
  def generate_short_url
    if self.new_record?
      self.short_url = SecureRandom.hex(5)
    end
  end
  
  def self.clean_times(args)
    result = {}
    
    args.each do |key, value|
      minutes = value.scan(/:(\d{2})/)[0][0].to_i
      if minutes >= 60
        hours = value.scan(/(\d{1,2}):/)[0][0].to_i
        ampm = value.scan(/(AM|PM)/)[0][0]
        
        if hours == 11
          ampm = "PM"
        end
        
        hours = (hours == 12) ? 1 : hours + 1
        
        minutes = "00"
        result[key] = "#{hours}:#{minutes} #{ampm}"
      else
        result[key] = value
      end
    end
    result
  end
  
  def self.time_intervals(early, late)
    (early..11).to_a.collect{|t| "#{t}:00 AM"} + ["12:00 PM"] + (1..late).to_a.collect{|t| "#{t}:00 PM"}
  end
end
