require 'csv'
require 'open-uri'

class BulkOperations::ImportCsv

  include BulkOperations::Lib::Common
  include Interactor

  def init
    @import = Import.find(context.import_id)
    @import.logs = ''
  end

  def call
    init

    @import.logs += "Starting #{@import.import_type} import process...\n"

    csv = CSV.parse(@import.csv_content, headers: true, converters: nil)
    case @import.import_type.to_sym
    when :artworks
      import_artworks(csv)
    end

    @import.logs += "\n\nImport complete"
    @import.status = :success
    @import.save!
  end

end
