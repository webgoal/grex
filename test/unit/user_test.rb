require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_list_talk_ids
    list = User.talk_ids 1, '2011-06-29'
    
    assert list.size == 2
    assert_equal [5, 1], list 
  end
end
