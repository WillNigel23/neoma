require 'csv'

class BulkOperations::ExportCsv

  include BulkOperations::Lib::Common
  include Interactor

  def init
    @type = context.type

    context.fail!(message: 'Provide a type') if @type.blank?
  end

  def call
    init

    begin
      case @type.to_sym
      when :artworks
        csv = export_artworks
      end

      context.file = csv
      context.filename = "#{@type}_#{Time.current.to_i}.csv"
    rescue StandardError => e
      context.fail!(message: e)
    end
  end

end
