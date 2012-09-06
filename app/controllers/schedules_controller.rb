# coding: utf-8
class SchedulesController < ApplicationController
  protect_from_forgery
  
  respond_to :json
  
  def index
    @my_user = current_user
    
    @days = {"dia_5" => "2012-09-05","dia_6" => "2012-09-06","dia_7" => "2012-09-07"}

    @lista = Hash.new

    for grupo, dia in @days do
      @lista[grupo] = {
        :keynote => {:name => "Keynote", :talks => Talk.track_day(dia, "keynote")},
        :convidados => {:name => "Convidados", :talks => Talk.track_day(dia, "convidado")},
        :desenvolvimento => {:name => "Desenvolvimento e Teste", :talks => Talk.track_day(dia, "desenvolvimento")},
        :analise => {:name => "Análise e Planejamento", :talks => Talk.track_day(dia, "lise")},
        :gestao => {:name => "Gestão e Cultura", :talks => Talk.track_day(dia, "gest")},
        :inovacao => {:name => "Inovação e Empreendedorismo", :talks => Talk.track_day(dia, "inova")},
        :relatos => {:name => "Relatos de Experiência", :talks => Talk.track_day(dia, "relatos")},
      }
    end      

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
