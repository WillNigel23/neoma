module V2
  module Admin
    class ExhibitsController < BaseController

      def index
        @exhibits = Exhibit.all.includes(:featured_item)
      end

      def new
        @exhibit = Exhibit.new
        @artworks = Artwork.all.order(title: :asc).pluck(:title, :id)
      end

      def edit
        @exhibit = Exhibit.find(params[:id])
        @artworks = Artwork.all.order(title: :asc).pluck(:title, :id)
      end

      def create
        @exhibit = Exhibit.new(exhibit_params)

        if @exhibit.save
          nested_content_sections_update_callback(:exhibit)

          flash[:notice] = "Created #{@exhibit.title} successfully"
          redirect_to edit_v2_admin_exhibit_path(@exhibit.id)
        else
          flash[:notice] = "Failed to create due to #{@exhibit.errors.full_messages}"
          @artworks = Artwork.all.order(title: :asc).pluck(:title, :id)
          render :new
        end
      end

      def update
        @exhibit = Exhibit.find(params[:id])

        if @exhibit.update(exhibit_params)
          nested_content_sections_update_callback(:exhibit)

          flash[:notice] = "Updated #{@exhibit.title} successfully"
          redirect_to edit_v2_admin_exhibit_path(@exhibit.id)
        else
          flash[:notice] = "Failed to update due to #{@exhibit.errors.full_messages}"
          @artworks = Artwork.all.order(title: :asc).pluck(:title, :id)
          render :edit
        end
      end

      def destroy
        exhibit = Exhibit.find(params[:id]).destroy

        flash[:notice] = "Deleted '#{exhibit.title}' successfully"
        redirect_to v2_admin_exhibits_path
      end

      private

      def exhibit_params
        params.require(:exhibit).permit(
          :title,
          :subtitle,
          :description,
          :status,
          :start_date,
          :end_date,
          :banner_id,
          :poster_id,
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
