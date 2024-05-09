module V2
  class ArtistsController < ApplicationController

    def index
      @artists = Artist.live
    end

    def show
      @artist = Artist.friendly.find(params[:id])
      @artworks = @artist.artworks.live
      @artwork_ids = @artworks.pluck(:id)
      @suggested_artists = Artist.live.where.not(id: @artist.id).order('RANDOM()').limit(5)
    end

  end
end
