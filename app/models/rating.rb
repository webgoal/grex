class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :talk
  
  scope :with_comments, lambda {where("comment not like ''")}
end