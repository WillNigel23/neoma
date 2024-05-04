# frozen_string_literal: true

module V2
  class ArtistsController < ApplicationController
    def index
      @artists = Artist.live
    end

    def show
      @artist = Artist.friendly.find(params[:id])
    end
  end
end
