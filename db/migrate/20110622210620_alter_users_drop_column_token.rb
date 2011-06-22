class AlterUsersDropColumnToken < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.remove :token
    end
  end

  def self.down
    change_table :users do |t|
      t.string :token
    end
  end
end
