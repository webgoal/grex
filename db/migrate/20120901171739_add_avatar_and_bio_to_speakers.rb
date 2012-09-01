class AddAvatarAndBioToSpeakers < ActiveRecord::Migration
  def self.up
    add_column :speakers, :avatar, :string
    add_column :speakers, :bio, :text
  end

  def self.down
    remove_column :users, :avatar
    remove_column :users, :bio
  end
end
