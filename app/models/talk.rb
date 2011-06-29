class Talk < ActiveRecord::Base
  has_and_belongs_to_many :speakers, :join_table => "talks_speakers"
  has_and_belongs_to_many :users, :join_table => "notebooks", :foreign_key => "talk_id", :uniq => true
  
  scope :in_order, order(:start)
  scope :from_track, lambda {|track| where('track like ?', '%'+track+'%')}
  scope :by_day, lambda {|date| where('date(start) = ?', date)}
  
  def self.track_day(date, track)
    self.by_day(date).from_track(track).in_order
  end
  
  def viewers 
    Talk.find(self.id).users.count
  end
  
  #Sobrescreve o nome da coluna de herança padrão do Rails type para type_id, evita conflitos
  set_inheritance_column do
    original_inheritance_column + "_id"
  end
end
