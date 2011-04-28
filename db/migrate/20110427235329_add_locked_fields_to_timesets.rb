class AddLockedFieldsToTimesets < ActiveRecord::Migration
  def self.up
    add_column :timesets, :locked, :boolean, :default => false
    add_column :timesets, :lock_password, :string
    add_column :timesets, :lock_salt, :string
  end

  def self.down
    remove_column :timesets, :locked
    remove_column :timesets, :lock_salt
    remove_column :timesets, :lock_password
  end
end
