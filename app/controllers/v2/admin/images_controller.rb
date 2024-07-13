module V2
  module Admin
    class ImagesController < BaseController

      def index
        @images = Image.all.order(id: :desc)

        @element_id = params[:element_id]
        @form_name = params[:form_name]
        @multiple = params[:multiple]
        respond_to(&:turbo_stream)
      end

      def create
        @image_upload = ImageUpload.new(image_params)

        return unless @image_upload.valid?

        image_params[:files].each do |file|
          Image.create(file:)
        end

        @images = Image.all.order(id: :desc)
        respond_to(&:turbo_stream)
      end

      def insert_image
        @element_id = params[:element_id]
        @form_name = params[:form_name]
        @multiple = params[:multiple]

        @image = Image.find_by(id: params[:image_id])
        respond_to(&:turbo_stream)
      end

      private

      def image_params
        params.require(:image_upload).permit(files: [])
      end

    end
  end
end
