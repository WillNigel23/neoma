class RemoveUniqueIndexOnArtworkTitle < ActiveRecord::Migration[7.1]

  def change
    remove_index :artworks, :title, unique: true
  end

end
