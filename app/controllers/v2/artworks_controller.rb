module V2
  class ArtworksController < ApplicationController

    def index
      @artworks = Artwork.live.includes(:artist).order(build_sorting_params)
      @artwork_ids = @artworks.to_a.pluck(:id)

      respond_to do |format|
        format.turbo_stream
        format.html
      end
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
      when 'homepage'
        artworks = FeaturedItem.artworks.order(position: :asc).
          map { |item| item.featureable if item.featureable.status == 'live' }
      else
        artworks = Artwork.live.includes(:artist)
      end

      artworks
    end

    def build_sorting_params
      params[:sort_by] ||= 'title'
      sort_by = params[:sort_by]&.to_sym

      Artwork::SORTING_PARAMS[sort_by] || 'title ASC'
    end

  end
end
