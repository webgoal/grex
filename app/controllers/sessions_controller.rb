class SessionsController < ApplicationController
  def create
    render :text => request.env['omniauth.auth']
  end
end
