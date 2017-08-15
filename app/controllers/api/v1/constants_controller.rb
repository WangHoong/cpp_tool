module Api
  module V1
    class ConstantsController < BaseController

      def genres
        parent_id = params[:parent_id] || 0
        @genres = Genre.where(parent_id: parent_id)
        render json: {genres: @genres}
      end
 
      def album_types
        render json: CONSTANTS['album_types']
      end

      def artist_types
        render json: CONSTANTS['artist_types']
      end

      def languages
        @languages = Language.all
        render json: {languages: @languages}
      end

    end
  end
end
