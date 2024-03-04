# frozen_string_literal: true

module Spina
  module Parts
    class FeaturedEvent < Base
      attr_json :event_ids, :integer, array: true, default: []

      def content
        Spina::Page.where(view_template: 'event', id: event_ids)
      end
    end
  end
end
