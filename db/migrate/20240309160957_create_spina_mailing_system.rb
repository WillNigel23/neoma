# frozen_string_literal: true

class CreateSpinaMailingSystem < ActiveRecord::Migration[7.1]
  def change
    create_table :spina_mailinglists, force: :cascade do |t|
      t.string :email, null: false
      t.timestamps
    end

    create_table :spina_mails, force: :cascade do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone_number, null: false
      t.text :message, null: false

      t.integer :artwork_id

      t.timestamps
    end
  end
end
