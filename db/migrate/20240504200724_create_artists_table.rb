class CreateArtistsTable < ActiveRecord::Migration[7.1]

  def change
    create_table :artists do |t|
      t.string      :name, null: false
      t.string      :slug
      t.string      :full_name
      t.string      :description
      t.string      :role
      t.integer     :status, null: false, default: 0

      t.references  :banner, foreign_key: { to_table: :images }
      t.references  :portrait, foreign_key: { to_table: :images }

      t.timestamps

      t.index [:name], name: 'unique_slug_per_artist', unique: true
    end
  end

end
