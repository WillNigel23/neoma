module V2
  module Admin
    class ArtworksController < BaseController

      def index
        @artworks = Artwork.all.includes(:featured_item)
      end

      def new
        @artwork = Artwork.new
        @artists = Artist.all.order(name: :asc).pluck(:name, :id)
      end

      def edit
        @artwork = Artwork.find(params[:id])
        @artists = Artist.all.order(name: :asc).pluck(:name, :id)
      end

      def create
        @artwork = Artwork.new(artwork_params)

        if @artwork.save
          nested_content_sections_update_callback(:artwork)

          flash[:notice] = "Created #{@artwork.title} successfully"
          redirect_to edit_v2_admin_artwork_path(@artwork.id)
        else
          flash[:notice] = "Failed to create due to #{@artwork.errors.full_messages}"
          @artists = Artist.all.order(name: :asc).pluck(:name, :id)
          render :new
        end
      end

      def update
        @artwork = Artwork.find(params[:id])

        if @artwork.update(artwork_params)
          nested_content_sections_update_callback(:artwork)

          flash[:notice] = "Updated #{@artwork.title} successfully"
          redirect_to edit_v2_admin_artwork_path(@artwork.id)
        else
          flash[:notice] = "Failed to update due to #{@artwork.errors.full_messages}"
          @artists = Artist.all.order(name: :asc).pluck(:name, :id)
          render :edit
        end
      end

      def destroy
        artwork = Artwork.find(params[:id]).destroy

        flash[:notice] = "Deleted '#{artwork.title}' successfully"
        redirect_to v2_admin_artworks_path
      end

      private

      def artwork_params
        params.require(:artwork).permit(
          :title,
          :description,
          :status,
          :sale_status,
          :medium,
          :price,
          :size,
          :year,
          :artist_id,
          :image_id
        )
      end

    end
  end
end
