class SchedulesController < ApplicationController
  protect_from_forgery
  
  respond_to :json
  
  def index
  end
  
  def check
    @notebook = Notebook.new
    @notebook.user_id = 1
    @notebook.talk_id = params[:palestra] 
    @notebook.save
    respond_with(@notebook)
  end
  
  def uncheck
    @notebook = Notebook.find(:first, :conditions => ['talk_id', params[:palestra]])
    @notebook.destroy unless @notebook.nil? 
    respond_with(@notebook)
  end
  
  def v
  end
end
