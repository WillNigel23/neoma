class CreateArticlesTables < ActiveRecord::Migration[7.1]

  def change
    create_table :articles do |t|
      t.string      :title, null: false
      t.string      :slug
      t.string      :subtitle
      t.text        :description

      t.integer     :status, null: false, default: 0

      t.date        :date, null: false

      t.references  :banner, foreign_key: { to_table: :images }

      t.timestamps

      t.index [:title], name: 'unique_slug_per_article', unique: true
    end
  end

end
