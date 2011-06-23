class UsersController < ApplicationController
  def list
    @talks = {
      :first => current_user.talks.by_day("2011-06-29").in_order,
      :second => current_user.talks.by_day("2011-06-30").in_order,
      :third => current_user.talks.by_day("2011-07-01").in_order
    }
  end

end
