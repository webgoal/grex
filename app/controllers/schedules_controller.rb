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
      :gestao => Talk.track_day(params[:date], "gestao"),
      :principal => Talk.track_day(params[:date], "principal")
    }
  end
  
  def check
    @notebook = Notebook.new
    @notebook.user_id = current_user.id
    @notebook.talk_id = params[:palestra] 
    @notebook.save
    respond_with(@notebook)
  end
  
  def uncheck
    @notebook = Notebook.find(:first, :conditions => {:talk_id => params[:palestra], :user_id => current_user.id})
    @notebook.destroy unless @notebook.nil? 
    respond_with(@notebook)
  end
  
  def v
  end
end
