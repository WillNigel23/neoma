class CreateGalleriesTables < ActiveRecord::Migration[7.1]

  def change
    create_table :galleries do |t|
      t.string      :title, null: false
      t.string      :slug
      t.string      :location
      t.text        :description

      t.integer     :status, null: false, default: 0

      t.references  :banner, foreign_key: { to_table: :images }

      t.timestamps

      t.index [:title], name: 'unique_slug_per_gallery', unique: true
    end
  end

end
