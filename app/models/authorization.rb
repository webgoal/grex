class Authorization < ActiveRecord::Base
  belongs_to :useassociation
  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider
end
