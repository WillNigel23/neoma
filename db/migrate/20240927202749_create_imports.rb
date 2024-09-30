class CreateImports < ActiveRecord::Migration[7.1]

  def change
    create_table :imports do |t|
      t.integer :status, default: 0, null: false
      t.integer :import_type, null: false

      t.text :csv_content
      t.text :logs

      t.timestamps
    end
  end

end
