module V2
  class GalleriesController < ApplicationController

    def index
      @galleries = Gallery.live
    end

    def show
      @gallery = Gallery.friendly.find(params[:id])
      @artworks = @gallery.artworks.live
      @artwork_ids = @artworks.pluck(:id)
      @suggested_galleries = Gallery.live.where.not(id: @gallery.id).order('RANDOM()').limit(5)
    end

  end
end
