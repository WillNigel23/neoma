class AddGalleryArtworks < ActiveRecord::Migration[7.1]

  def change
    create_table :gallery_artworks do |t|
      t.references :gallery, foreign_key: true
      t.references :artwork, foreign_key: true

      t.index [:gallery_id, :artwork_id], name: 'index_gallery_artworks', unique: true
    end
  end

end
