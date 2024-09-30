class BulkOperations::ScheduleImportCsv

  include Interactor

  def init
    @import_type = context.import_params[:import_type]&.to_sym
    @file = context.import_params[:file]

    context.fail!(message: 'Provide a type') if @import_type.blank?
    context.fail!(message: 'No file submitted') if @file.blank?
    context.fail!(message: 'Unsupported file type') unless @file.content_type.in?(['text/csv', 'application/csv'])
  end

  def call
    init

    csv_import = Import.create!(import_type: @import_type, csv_content: @file.read)

    # ImportCsvJob.perform_later(csv_import.id)
    BulkOperations::ImportCsv.call(import_id: csv_import.id)
  end

end
