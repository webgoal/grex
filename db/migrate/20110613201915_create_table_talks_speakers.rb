class CreateTableTalksSpeakers < ActiveRecord::Migration
  def self.up
    create_table :talks_speakers, :id => false do |t|
      t.references :talk, :null => false
      t.references :speaker, :null => false
    end
  end

  def self.down
    drop_table :talks_speakers
  end
end
