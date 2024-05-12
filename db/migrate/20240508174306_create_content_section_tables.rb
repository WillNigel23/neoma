class CreateContentSectionTables < ActiveRecord::Migration[7.1]

  def change
    create_table :content_sections do |t|
      t.references :contentable, polymorphic: true, index: true
      t.string :header
    end
  end

end
