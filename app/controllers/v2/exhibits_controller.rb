# frozen_string_literal: true

module V2
  class ExhibitsController < ApplicationController
    def index
      @past_exhibits = Exhibit.live.past
      @ongoing_exhibits = Exhibit.live.ongoing
    end

    def show
      @exhibit = Exhibit.friendly.find(params[:id])
    end
  end
end
