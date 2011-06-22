class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, { :options => "ENGINE=InnoDB" } do |t|
      t.primary_key :id
      t.string :twitter, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end