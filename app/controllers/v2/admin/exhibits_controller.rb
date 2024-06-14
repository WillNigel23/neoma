module V2
  module Admin
    class ExhibitsController < BaseController

      def index
        @exhibits = Exhibit.all.includes(:featured_item)
      end

      def edit
        @exhibit = Exhibit.find(params[:id])
        @artworks = Artwork.all.order(title: :asc).pluck(:title, :id)
      end

      def update
        @exhibit = Exhibit.find(params[:id])

        if @exhibit.update(exhibit_params)
          destroy_nested_content_sections
          flash[:notice] = "Updated #{@exhibit.title} successfully"
          redirect_to edit_v2_admin_exhibit_path(@exhibit.id)
        else
          render :edit
        end
      end

      def destroy
        exhibit = Exhibit.find(params[:id]).destroy

        flash[:notice] = "Deleted '#{exhibit.title}' successfully"
        redirect_to v2_admin_exhibits_path
      end

      private

      def destroy_nested_content_sections
        permitted_params = params.require(:exhibit).permit(
          content_sections_attributes: [:id, :_destroy]
        )

        content_sections_params = permitted_params[:content_sections_attributes].to_h

        content_sections_params.each do |(_, attributes)|
          next if attributes[:_destroy] == 'false'

          ContentSection.find_by(id: attributes[:id])&.destroy!
        end
      end

      def exhibit_params
        permitted_params = params.require(:exhibit).permit(
          :title,
          :subtitle,
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
            :_destroy,
            { image_ids: [] }
          ]
        )

        content_sections_attributes = permitted_params[:content_sections_attributes].to_h

        content_sections_attributes.each_with_index do |(_, attributes), index|
          attributes[:position] = index + 1
        end

        permitted_params.merge(content_sections_attributes:)
      end

    end
  end
end
