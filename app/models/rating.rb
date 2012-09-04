class Rating < ActiveRecord::Base
  has_many :authorizations
  has_and_belongs_to_many :talks, :join_table => "notebooks", :foreign_key => "user_id"
end