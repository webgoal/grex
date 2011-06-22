class Talk < ActiveRecord::Base
  has_and_belongs_to_many :speakers, :join_table => "talks_speakers"
  
  set_inheritance_column do
    original_inheritance_column + "_id"
  end
end
