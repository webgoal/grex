class CreateTableTalksSpeakers < ActiveRecord::Migration
  def self.up
    create_table :talks_speakers, { :options => "ENGINE=InnoDB" } do |t|
      t.integer :talk_id, :null => false
      t.integer :speaker_id, :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :talks_speakers
  end
end
