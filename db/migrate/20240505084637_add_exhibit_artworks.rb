class AddExhibitArtworks < ActiveRecord::Migration[7.1]

  def change
    create_table :exhibit_artworks do |t|
      t.references :exhibit, foreign_key: true
      t.references :artwork, foreign_key: true

      t.index [:exhibit_id, :artwork_id], name: 'index_exhibit_artworks', unique: true
    end
  end

end
