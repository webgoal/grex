class SchedulesController < ApplicationController
  protect_from_forgery
  
  respond_to :json
  
  def index
    @my_user = current_user
    
    params[:date] ||= "2011-06-29"
    
    @tracks = {
      :geral => Talk.track_day(params[:date], "geral"),
      :engenharia => Talk.track_day(params[:date], "engenharia"),
      :relatos => Talk.track_day(params[:date], "relatos"),
      :gestao => Talk.track_day(params[:date], "gest"),
      :principal => Talk.track_day(params[:date], "principal")
    }
    @user_tracks = current_user.talk_ids params[:date]
  end
  
  def check
    @notebook = Notebook.new
    @notebook.user_id = current_user.id
    @notebook.talk_id = params[:palestra] 
    @notebook.save
    respond_with(@notebook)
  end
  
  def uncheck
    current_user.talks.delete(Talk.find(params[:palestra]))
    respond_with({})
  end

end
