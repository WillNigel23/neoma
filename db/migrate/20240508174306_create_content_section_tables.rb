# frozen_string_literal: true

class CreateContentSectionTables < ActiveRecord::Migration[7.1]
  def change
    create_table :content_sections do |t|
      t.references :artist, foreign_key: true
      t.references :exhibit, foreign_key: true

      t.string :header
    end
  end
end
