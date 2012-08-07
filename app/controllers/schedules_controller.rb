class SchedulesController < ApplicationController
  protect_from_forgery
  
  respond_to :json
  
  def index
    @my_user = current_user

    params[:date] ||= Time.new.strftime("%Y-%m-%d")

    @tracks2 = {
      :geral => Talk.track_day(params[:date], "geral"),
      :engenharia => Talk.track_day(params[:date], "engenharia"),
      :relatos => Talk.track_day(params[:date], "relatos"),
      :gestao => Talk.track_day(params[:date], "gest"),
      :principal => Talk.track_day(params[:date], "principal")
    }
    
    @tracks = {
      :desenvolvimento => Talk.track_day(params[:date], "desenvolvimento"),
      :analise => Talk.track_day(params[:date], "lise"),
      :gestao => Talk.track_day(params[:date], "gest"),
      :inovacao => Talk.track_day(params[:date], "inova"),
      :relatos => Talk.track_day(params[:date], "relatos")
    }
    
    @user_tracks = current_user.talk_ids params[:date]
    @date = params[:date]
    
  end
  
  def check
    @notebook = Notebook.new
    @notebook.user_id = current_user.id
    @notebook.talk_id = params[:palestra] 
    @notebook.save
    respond_with({})
  end
  
  def uncheck
    current_user.talks.delete(Talk.find(params[:palestra]))
    respond_with({})
  end

end
