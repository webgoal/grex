class User < ActiveRecord::Base
  has_many :authorizations
  has_and_belongs_to_many :talks, :join_table => "notebooks", :foreign_key => "user_id"

  def self.create_from_hash!(hash)
    create(:twitter => hash['user_info']['nickname'], :avatar =>  hash['user_info']['image'])
  end
  
  def talk_ids(date = nil)
    base_query = User.find(self.id).talks.select('id').order('start')
    base_query = base_query.by_day(date) unless date.nil? 
    base_query.map{|x| x.id}
  end
end
