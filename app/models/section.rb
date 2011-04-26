class Section < ActiveRecord::Base
  validates_presence_of :start, :end, :timeset_id
  belongs_to :timeset
end
