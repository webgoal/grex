class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings, { :options => "ENGINE=InnoDB", :primary_key => :id } do |t|
      t.column :id, "INT UNSIGNED", :null => false
      t.integer :value, :null => false
      t.string :comment
      t.references :user, :null => false
      t.references :talk, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :ratings
  end
end
