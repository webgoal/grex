class User < ActiveRecord::Base
  has_many :authorizations
  has_and_belongs_to_many :talks, :join_table => "notebooks", :foreign_key => "user_id"

  def self.create_from_hash!(hash)
    create(:twitter => hash['user_info']['nickname'])
  end
  
  def self.talk_ids(user_id, date)
    self.find(user_id).talks.select('id').by_day(date).order('start').map{|x| x.id}
  end
end
