class CreateArtworksTable < ActiveRecord::Migration[7.1]

  def change
    create_table :artworks do |t|
      t.string      :title, null: false
      t.string      :slug
      t.references  :artist, foreign_key: true

      t.string      :size
      t.string      :medium
      t.integer     :year
      t.text        :description
      t.integer     :price

      t.integer     :status, null: false, default: 0

      t.timestamps

      t.index [:title], name: 'unique_slug_per_artwork', unique: true
    end
  end

end
