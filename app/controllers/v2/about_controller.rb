module V2
  class AboutController < ApplicationController

    def index
      @angel = Artist.friendly.find('angel-gonzales')
      @reiner = Artist.friendly.find('reinier-lacsamana')
      @marie = Artist.friendly.find('marie-cresilda-basilio')
      @jareth = Artist.friendly.find('ericson-val-jareta')

      @artists = [@angel, @reiner, @marie, @jareth]
    end

  end
end
