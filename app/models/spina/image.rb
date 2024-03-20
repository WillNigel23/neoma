# frozen_string_literal: true

module Spina
  class Image < ApplicationRecord
    include Attachable

    belongs_to :media_folder, optional: true

    scope :sorted, -> { order('created_at DESC') }

    def variant(options, force_variant = false)
      return '' unless file.attached?
      return file if file.content_type.include?('svg')
      return file unless file.variable?
      return file unless force_variant

      file.variant(options)
    end

    def content
      self
    end

    def thumbnail(size = '100x100', modifier = '^', force_variant = false)
      return self unless force_variant

      variant(
        combine_options: {
          gravity: 'center',
          thumbnail: "#{size}#{modifier}",
          extent: size
        }
      )
    end
  end
end
