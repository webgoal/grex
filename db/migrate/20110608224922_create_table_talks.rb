class CreateTableTalks < ActiveRecord::Migration
  def self.up
    execute "
    CREATE TABLE talks (
      id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
      title VARCHAR(100)  NOT NULL,
      theme VARCHAR(100)  NOT NULL,
      talkers VARCHAR(100) NOT NULL,
      css_class_time VARCHAR(20) NOT NULL,
      date DATE NOT NULL,
      room VARCHAR(30) NOT NULL,
      created_at DATETIME  NOT NULL,
      modified_at DATETIME, 
      PRIMARY KEY (id)
    ) ENGINE = InnoDB;"
  end

  def self.down
    execute "DROP TABLE talks"
  end
end
