class ChangeTimeFieldsToStrings < ActiveRecord::Migration
  def self.up
    change_column :sections, :start, :string
    change_column :sections, :end, :string
  end

  def self.down
    change_column :sections, :start, :time
    change_column :sections, :end, :time
  end
end
