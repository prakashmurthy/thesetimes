class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.time :start
      t.time :end
      t.integer :timeset_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sections
  end
end
