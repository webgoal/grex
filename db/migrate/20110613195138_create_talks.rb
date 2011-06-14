class CreateTalks < ActiveRecord::Migration
  def self.up
    create_table :talks, { :options => "ENGINE=InnoDB", :primary_key => :id } do |t|
      t.column :id, "INT UNSIGNED", :null => false
      t.string :title
      t.string :language
      t.string :level
      t.integer :attendees_limit
      t.string :type
      t.string :track
      t.string :room
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
