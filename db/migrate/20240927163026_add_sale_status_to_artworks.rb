class AddSaleStatusToArtworks < ActiveRecord::Migration[7.1]

  def change
    add_column :artworks, :sale_status, :integer, null: false, default: 0
  end

end
