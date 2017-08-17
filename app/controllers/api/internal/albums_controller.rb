class Api::Internal::AlbumsController < ApplicationController

  def index
    ids = params[:ids]
    albums = Album.where(id: ids)
    if albums.present?
      track_ids = albums.map{|album| album.tracks.map(&:id)}.flatten.compact
      synchro = Synchro.new
      data = synchro.tracks(ids: track_ids)
      if data["state"] == true && data["result"].present?
        data["result"].each do |obj|
          @track = Track.where(id: obj['id']).first
          @track.update(th_id: obj['th_id']) if @track
        end
      end
      head :ok
    else
        render json: {status: 403 }, status: :unprocessable_entity
    end
  end

end
