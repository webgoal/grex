class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    unless @auth = Authorization.find_from_hash(auth)
     @auth = Authorization.create_from_hash(auth)
    end
    self.current_user = @auth.user
    redirect_to "/schedules"
  end

  def logout
    session[:user_id] = nil
    redirect_to "/schedules"
  end
end
