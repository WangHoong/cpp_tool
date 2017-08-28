class Api::Internal::TracksController < ApplicationController

   def index
      ids = params[:ids]
      synchro = Synchro.new
      data = synchro.tracks(ids: ids)
      if data["result"] && data["state"] == true
        data["result"].each do |obj|
          @track = Track.where(id: obj['id']).first
          @track.update(th_id: obj['th_id']) if @track
        end
        head :ok
      else
        render json: {status: 404 }, status: :unprocessable_entity
      end
   end

end
