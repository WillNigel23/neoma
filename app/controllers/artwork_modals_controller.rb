class ArtworkModalsController < ApplicationController

  def show_modal
    artwork_ids = [params[:active]] + params[:artworks].reject { |id| id == params[:active] }
    @artworks = artworks.where(id: artwork_ids)
    @artworks = @artworks.sort_by { |artwork| artwork_ids.index(artwork.id.to_s) }

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def show_sidemodal
    @inquiry = Spina::Mail.new
    @artwork = params[:artwork].present? ? artworks.find(params[:artwork]) : nil
    respond_to(&:turbo_stream)
  end

  def show_inquire_modal
  end

  def close_sidemodal
    respond_to(&:turbo_stream)
  end

  def close_modal
    respond_to(&:turbo_stream)
  end

  private

  def artworks
    @artworks ||= Spina::Resource.find_by(name: 'artworks').pages
  end

end
