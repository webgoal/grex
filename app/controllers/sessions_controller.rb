class SessionsController < ApplicationController
  
  before_filter :session_control, :except => [:login, :create]
  
  def create
    auth = request.env['omniauth.auth']
    unless @auth = Authorization.find_from_hash(auth)
     @auth = Authorization.create_from_hash(auth)
    end
    self.current_user = @auth.user
    redirect_to "/schedules"
  end
  
  def login
    redirect_to("/schedules") if signed_in?
  end

  def logout
    session[:user_id] = nil
    redirect_to "/"
  end
end
