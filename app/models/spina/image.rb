# frozen_string_literal: true

# == Schema Information
#
# Table name: spina_images
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  media_folder_id :integer
#
# Indexes
#
#  index_spina_images_on_media_folder_id  (media_folder_id)
#
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
