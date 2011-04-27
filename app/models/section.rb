class Section < ActiveRecord::Base
  validates_presence_of :start, :end, :day, :timeset_id
  belongs_to :timeset
  
  def time_range
    "#{start} to #{self.end}"
  end
end
