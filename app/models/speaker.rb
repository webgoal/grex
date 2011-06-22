class Speaker < ActiveRecord::Base
  has_and_belongs_to_many :talks, :join_table => "talks_speakers"
end
