module Spina
  module Parts
    class DatePicker < Base

      attr_json :date, :datetime

      def content
        date&.strftime('%d, %B %Y')
      end

    end
  end
end
