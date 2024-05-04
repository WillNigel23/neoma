# frozen_string_literal: true

class AddExhibitArtistsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :exhibit_artists do |t|
      t.references :exhibit, foreign_key: true
      t.references :artist, foreign_key: true

      t.index %i[exhibit_id artist_id], name: 'index_exhibit_artists', unique: true
    end
  end
end
