# frozen_string_literal: true

class CreateExhibitsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :exhibits do |t|
      t.string      :title, null: false
      t.string      :slug
      t.string      :subtitle
      t.text        :summary
      t.integer     :status, null: false, default: 0

      t.date        :start_date, null: false
      t.date        :end_date

      t.timestamps

      t.index [:title], name: 'unique_slug_per_exhibit', unique: true
    end
  end
end
