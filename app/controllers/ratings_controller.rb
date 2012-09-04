class RatingsController < ApplicationController
  
  def new 
    @rating = Rating.new
    @talk = Talk.find(params[:id])
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rating }
    end
  end
  
  def create
    @rating = Rating.new(params[:rating])
    @talk = Talk.find(params[:rating][:talk_id])
    
      if @rating.save
        redirect_to :controller => "schedules", :action => "index", notice: 'Avaliado com sucesso.'  
      else
        render action: "new"
      end
      
  end
end
