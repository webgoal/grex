require 'test_helper'

class SchedulesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
  
  test "local variables must be set" do
    get :index, {:date => '2011-06-30'}
    
    tracks = assigns(:tracks)
    assert_not_nil tracks
    
    assert tracks[:geral].size == 1
    assert tracks[:engenharia].size == 2
    assert tracks[:relatos].size == 1
    assert tracks[:gestao].size == 1
    assert tracks[:principal].size == 1
  end
end
