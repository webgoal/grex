class User < ActiveRecord::Base
  has_many :authorizations

  def self.create_from_hash!(hash)
    create(:twitter => hash['user_info']['nickname'], :token => 'ajsdflkajshfalsf')
  end
end
