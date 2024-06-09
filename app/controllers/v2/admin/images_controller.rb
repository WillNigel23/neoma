module V2
  module Admin
    class ImagesController < BaseController

      def index
        @images = Image.all

        @element_id = params[:element_id]
        @form_id = params[:form_id]
        @form_name = params[:form_name]
        respond_to(&:turbo_stream)
      end

      def insert_image
        @element_id = params[:element_id]
        @form_id = params[:form_id]
        @form_name = params[:form_name]

        @image = Image.find_by(id: params[:image_id])
        respond_to(&:turbo_stream)
      end

    end
  end
end
