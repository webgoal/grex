class TalksController < ApplicationController

    def show
        @talk = Talk.find(params[:id])
    end

end
