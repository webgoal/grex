class UsersController < ApplicationController
  def list
    list_from_user current_user
  end
  
  def from_user
    user_id = params[:id]
    @user = User.find(user_id)
    
    list_from_user(@user)
  end
  
  private
  def list_from_user(user)
    @talks = {
      :first => user.talks.by_day("2012-09-05").in_order,
      :second => user.talks.by_day("2012-09-06").in_order,
      :third => user.talks.by_day("2012-09-07").in_order
    }
  end

end
