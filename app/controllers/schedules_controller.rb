# coding: utf-8
class SchedulesController < ApplicationController
  protect_from_forgery
  
  respond_to :json
  
  def index
    @my_user = current_user

    params[:date] ||= "2012-09-05" #Time.new.strftime("%Y-%m-%d")
    
    @tracks = {
      :convidados => {:name => "Convidados", :talks => Talk.track_day(params[:date], "convidado")},
      :desenvolvimento => {:name => "Desenvolvimento e Teste", :talks => Talk.track_day(params[:date], "desenvolvimento")},
      :analise => {:name => "Análise e Planejamento", :talks => Talk.track_day(params[:date], "lise")},
      :gestao => {:name => "Gestão e Cultura", :talks => Talk.track_day(params[:date], "gest")},
      :inovacao => {:name => "Inovação e Empreendedorismo", :talks => Talk.track_day(params[:date], "inova")},
      :relatos => {:name => "Relatos de Experiência", :talks => Talk.track_day(params[:date], "relatos")},
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
