class ImportCsvJob < ApplicationJob

  queue_as :default

  def perform(import_id)
    @error_logs = ''

    @result = BulkOperations::ImportCsv.call(import_id:)
  rescue StandardError => e
    @error_logs += "#{e.message}\n"
    @result.import&.status = :failed
  ensure
    @result.import&.logs += "\n\n#{@error_logs}"
    @result.import&.save!
  end

end
