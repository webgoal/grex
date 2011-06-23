class TalksController < ApplicationController

    def show
        @talk = Talk.find(params[:id])
        @user_tracks = current_user.talk_ids
    end

end
