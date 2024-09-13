module V2
  module Admin
    class GalleriesController < BaseController

      def index
        @galleries = Gallery.all.includes(:featured_item)
      end

      def new
        @gallery = Gallery.new
        @artworks = Artwork.all.order(title: :asc).pluck(:title, :id)
      end

      def edit
        @gallery = Gallery.find(params[:id])
        @artworks = Artwork.all.order(title: :asc).pluck(:title, :id)
      end

      def create
        @gallery = Gallery.new(gallery_params)

        if @gallery.save
          nested_content_sections_update_callback(:gallery)

          flash[:notice] = "Created #{@gallery.title} successfully"
          redirect_to edit_v2_admin_gallery_path(@gallery.id)
        else
          flash[:notice] = "Failed to create due to #{@gallery.errors.full_messages}"
          @artworks = Artwork.all.order(title: :asc).pluck(:title, :id)
          render :new
        end
      end

      def update
        @gallery = Gallery.find(params[:id])

        if @gallery.update(gallery_params)
          nested_content_sections_update_callback(:gallery)

          flash[:notice] = "Updated #{@gallery.title} successfully"
          redirect_to edit_v2_admin_gallery_path(@gallery.id)
        else
          flash[:notice] = "Failed to update due to #{@gallery.errors.full_messages}"
          @artworks = Artwork.all.order(title: :asc).pluck(:title, :id)
          render :edit
        end
      end

      def destroy
        gallery = Gallery.find(params[:id]).destroy

        flash[:notice] = "Deleted '#{gallery.title}' successfully"
        redirect_to v2_admin_galleries_path
      end

      private

      def gallery_params
        params.require(:gallery).permit(
          :title,
          :location,
          :description,
          :status,
          :banner_id,
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
