class Api::Internal::TracksController < ApplicationController

   def index
      tracks = params[:tracks]
      if tracks.present?
        tracks.each do |track|
          @track = Track.where(id: track['id']).first
          @track.update(th_id: track['th_id']) if @track
        end
        head :ok
      else
        render json: {status: 404 }, status: :unprocessable_entity
      end
   end

end
