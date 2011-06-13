class CreateTalks < ActiveRecord::Migration
  def self.up
    create_table :talks, { :options => "ENGINE=InnoDB", :primary_key => :id } do |t|
      t.column :id, "INT UNSIGNED", :null => false
      t.string :title, :limit => 60
      t.string :language, :limit => 30
      t.string :level, :limit => 40
      t.integer :attendees_limit
      t.string :type, :limit => 40
      t.string :track, :limit => 40
      t.string :room, :limit => 20
      t.boolean :translation
      t.integer :duration, :null => false
      t.datetime :start, :null =>false
      t.datetime :end, :null => false
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :talks
  end
end
