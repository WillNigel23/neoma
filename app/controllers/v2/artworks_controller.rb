module V2
  class ArtworksController < ApplicationController

    def index
      @artworks = Artwork.live.includes(:artist).order(year: :desc)
      @artwork_ids = @artworks.to_a.pluck(:id)
    end

    def show
      @reference_id = params[:reference_id]
      @class_name = params[:class_name]

      @artworks = artworks_by_class_reference(@reference_id, @class_name)

      @position = @artworks.find_index { |artwork| artwork.slug == params[:id] } || 0

      respond_to do |format|
        format.turbo_stream
        format.html
      end
    end

    private

    def artworks_by_class_reference(reference_id, class_name)
      case class_name
      when 'artist'
        artworks = Artist.friendly.find(reference_id).artworks.live.includes(:artist)
      when 'exhibit'
        artworks = Exhibit.friendly.find(reference_id).artworks.live.includes(:artist)
      when 'gallery'
        artworks = Gallery.friendly.find(reference_id).artworks.live.includes(:artist)
      else
        artworks = Artwork.live.includes(:artist)
      end

      artworks
    end

  end
end
