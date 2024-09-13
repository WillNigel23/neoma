module V2
  module Admin
    class ArtistsController < BaseController

      def index
        @artists = Artist.all.includes(:featured_item)
      end

      def new
        @artist = Artist.new
        @artworks = Artwork.all.order(title: :asc).pluck(:title, :id)
      end

      def edit
        @artist = Artist.find(params[:id])
        @artworks = Artwork.all.order(title: :asc).pluck(:title, :id)
      end

      def create
        @artist = Artist.new(artist_params)

        if @artist.save
          nested_content_sections_update_callback(:artist)

          flash[:notice] = "Created #{@artist.name} successfully"
          redirect_to edit_v2_admin_artist_path(@artist.id)
        else
          flash[:notice] = "Failed to create due to #{@artist.errors.full_messages}"
          @artworks = Artwork.all.order(title: :asc).pluck(:title, :id)
          render :new
        end
      end

      def update
        @artist = Artist.find(params[:id])

        if @artist.update(artist_params)
          nested_content_sections_update_callback(:artist)

          flash[:notice] = "Updated #{@artist.name} successfully"
          redirect_to edit_v2_admin_artist_path(@artist.id)
        else
          flash[:notice] = "Failed to update due to #{@artist.errors.full_messages}"
          @artworks = Artwork.all.order(title: :asc).pluck(:title, :id)
          render :edit
        end
      end

      def destroy
        artist = Artist.find(params[:id]).destroy

        flash[:notice] = "Deleted '#{artist.title}' successfully"
        redirect_to v2_admin_artists_path
      end

      private

      def artist_params
        params.require(:artist).permit(
          :full_name,
          :name,
          :description,
          :status,
          :role,
          :banner_id,
          :portrait_id,
          artwork_ids: [],
          content_sections_attributes: [
            :id,
            :header,
            :content,
            :position,
            :_destroy
          ]
        )
      end

    end
  end
end
