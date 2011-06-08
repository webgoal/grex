class Initial < ActiveRecord::Migration
  def self.up
    execute "CREATE TABLE users (id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,twitter VARCHAR(100)  NOT NULL,token VARCHAR(100)  NOT NULL,created_at DATETIME  NOT NULL,modified_at DATETIME, PRIMARY KEY (id)) ENGINE = InnoDB;"

    execute "CREATE TABLE notebooks (id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,user_id VARCHAR(100)  NOT NULL,talk_id VARCHAR(100)  NOT NULL,created_at DATETIME  NOT NULL,modified_at DATETIME, PRIMARY KEY (id))ENGINE = InnoDB;"
  end

  def self.down
    execute "DROP TABLE users;"
    execute "DROP TABLE agendas;"
  end
end
