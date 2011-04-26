class CreateTimesets < ActiveRecord::Migration
  def self.up
    create_table :timesets do |t|
      t.string :short_url

      t.timestamps
    end
  end

  def self.down
    drop_table :timesets
  end
end
