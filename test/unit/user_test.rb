require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_list_talk_ids
    list = User.talk_ids 1, '2011-06-29'
    
    assert list.size == 2
    assert_equal [5, 1], list 
  end
  
  def test_list_talk_ids_without_date
    list = User.talk_ids 1
    assert list.size == 3
    assert_equal [5, 1, 2], list
  end
end
