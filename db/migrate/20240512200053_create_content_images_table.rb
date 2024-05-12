class CreateContentImagesTable < ActiveRecord::Migration[7.1]

  def change
    create_table :content_images do |t|
      t.references :image, foreign_key: { to_table: :images }
      t.references :content_section, foreign_key: { to_table: :content_sections }
    end
  end

end
