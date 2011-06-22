class CreateSpeakers < ActiveRecord::Migration
  def self.up
    create_table :speakers, { :options => "ENGINE=InnoDB" } do |t|
      t.primary_key :id
      t.string :name, :limit => 60, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :speakers
  end
end
