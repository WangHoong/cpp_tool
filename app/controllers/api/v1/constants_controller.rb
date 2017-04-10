module Api
  module V1
    class ConstantsController < BaseController

      def genres
        render json: CONSTANTS['genres']
      end

      def album_types
        render json: CONSTANTS['album_types']
      end

      def artist_types
        render json: CONSTANTS['artist_types']
      end

    end
  end
end