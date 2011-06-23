require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_list_talk_ids
    user = User.new
    user.id = 1
    list = user.talk_ids '2011-06-29'
    
    assert list.size == 2
    assert_equal [5, 1], list 
  end
  
  def test_list_talk_ids_without_date
    user = User.new
    user.id = 1
    list = user.talk_ids
    assert list.size == 3
    assert_equal [5, 1, 2], list
  end
end
