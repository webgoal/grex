class CreateNotebooks < ActiveRecord::Migration
  def self.up
    create_table :notebooks, { :options => "ENGINE=InnoDB", :id => false } do |t|
      t.references :user, :null => false
      t.references :talk, :null => false
    end
  end

  def self.down
    drop_table :notebooks
  end
end