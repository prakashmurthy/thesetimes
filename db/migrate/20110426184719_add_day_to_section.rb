class AddDayToSection < ActiveRecord::Migration
  def self.up
    add_column :sections, :day, :string
  end

  def self.down
    remove_column :sections, :day
  end
end
