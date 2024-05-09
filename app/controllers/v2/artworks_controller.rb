module V2
  class ArtworksController < ApplicationController

    def index
      @artworks = Artwork.live.order(year: :desc)
      @artwork_ids = @artworks.to_a.pluck(:id)
    end

    def show
      @artwork = Artwork.includes(:artist).friendly.find(params[:id])
      @artwork_ids = params[:artwork_ids].presence || Artwork.live.pluck(:id)
    end

  end
end
