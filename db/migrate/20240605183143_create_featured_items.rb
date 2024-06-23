class CreateFeaturedItems < ActiveRecord::Migration[7.1]

  def change
    create_table :featured_items do |t|
      t.references :featureable, polymorphic: true, index: true
      t.integer :position, null: false, default: 0
    end
  end

end
