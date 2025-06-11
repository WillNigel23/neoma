module V2
  module Admin
    class BulkOperationsController < BaseController

      def index
        @imports = Import.all.order(created_at: :desc)
      end

      def export_csv
        result = BulkOperations::ExportCsv.call(type: params[:type])

        if result.success?
          send_data(result.file, filename: result.filename, type: 'text/csv')
        else
          flash[:notice] = result.message
          redirect_to redirect_to_type_map[params[:type]&.to_sym || :homework]
        end
      end

      def import_csv
        result = BulkOperations::ScheduleImportCsv.call(import_params:)

        flash[:notice] = result.success? ? 'Processing import' : result.message
        redirect_to v2_admin_bulk_operations_path
      end

      private

      def import_params
        params.require(:import).permit(:import_type, :file)
      end

    end
  end
end
