module V2
  class ExhibitsController < ApplicationController

    def index
      @past_exhibits = Exhibit.live.past.order(start_date: :desc, end_date: :asc)
      @ongoing_exhibits = Exhibit.live.ongoing.order(start_date: :desc, end_date: :asc)
    end

    def show
      @exhibit = Exhibit.friendly.find(params[:id])
      @artworks = @exhibit.artworks.live
      @artwork_ids = @artworks.pluck(:id)
      @suggested_exhibits = Exhibit.live.where.not(id: @exhibit.id).order('RANDOM()').limit(5)
    end

  end
end
