# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_11_04_171056) do
  create_schema "heroku_ext"

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug"
    t.string "subtitle"
    t.text "description"
    t.integer "status", default: 0, null: false
    t.date "date", null: false
    t.bigint "banner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["banner_id"], name: "index_articles_on_banner_id"
    t.index ["title"], name: "unique_slug_per_article", unique: true
  end

  create_table "artists", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug"
    t.string "full_name"
    t.string "description"
    t.string "role"
    t.integer "status", default: 0, null: false
    t.bigint "banner_id"
    t.bigint "portrait_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["banner_id"], name: "index_artists_on_banner_id"
    t.index ["name"], name: "unique_slug_per_artist", unique: true
    t.index ["portrait_id"], name: "index_artists_on_portrait_id"
  end

  create_table "artworks", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug"
    t.bigint "artist_id"
    t.string "size"
    t.string "medium"
    t.integer "year"
    t.text "description"
    t.integer "price"
    t.integer "status", default: 0, null: false
    t.bigint "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sale_status", default: 0, null: false
    t.index ["artist_id"], name: "index_artworks_on_artist_id"
    t.index ["image_id"], name: "index_artworks_on_image_id"
  end

  create_table "content_images", force: :cascade do |t|
    t.bigint "image_id"
    t.bigint "content_section_id"
    t.integer "position", default: 0, null: false
    t.index ["content_section_id"], name: "index_content_images_on_content_section_id"
    t.index ["image_id"], name: "index_content_images_on_image_id"
  end

  create_table "content_sections", force: :cascade do |t|
    t.string "contentable_type"
    t.bigint "contentable_id"
    t.string "header"
    t.integer "position", default: 0, null: false
    t.index ["contentable_type", "contentable_id"], name: "index_content_sections_on_contentable"
  end

  create_table "exhibit_artworks", force: :cascade do |t|
    t.bigint "exhibit_id"
    t.bigint "artwork_id"
    t.index ["artwork_id"], name: "index_exhibit_artworks_on_artwork_id"
    t.index ["exhibit_id", "artwork_id"], name: "index_exhibit_artworks", unique: true
    t.index ["exhibit_id"], name: "index_exhibit_artworks_on_exhibit_id"
  end

  create_table "exhibits", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug"
    t.string "subtitle"
    t.text "description"
    t.integer "status", default: 0, null: false
    t.bigint "banner_id"
    t.bigint "poster_id"
    t.date "start_date", null: false
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["banner_id"], name: "index_exhibits_on_banner_id"
    t.index ["poster_id"], name: "index_exhibits_on_poster_id"
    t.index ["title"], name: "unique_slug_per_exhibit", unique: true
  end

  create_table "featured_items", force: :cascade do |t|
    t.string "featureable_type"
    t.bigint "featureable_id"
    t.integer "position", default: 0, null: false
    t.index ["featureable_type", "featureable_id"], name: "index_featured_items_on_featureable"
  end

  create_table "galleries", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug"
    t.string "location"
    t.text "description"
    t.integer "status", default: 0, null: false
    t.bigint "banner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["banner_id"], name: "index_galleries_on_banner_id"
    t.index ["title"], name: "unique_slug_per_gallery", unique: true
  end

  create_table "gallery_artworks", force: :cascade do |t|
    t.bigint "gallery_id"
    t.bigint "artwork_id"
    t.index ["artwork_id"], name: "index_gallery_artworks_on_artwork_id"
    t.index ["gallery_id", "artwork_id"], name: "index_gallery_artworks", unique: true
    t.index ["gallery_id"], name: "index_gallery_artworks_on_gallery_id"
  end

  create_table "images", force: :cascade do |t|
  end

  create_table "imports", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.integer "import_type", null: false
    t.text "csv_content"
    t.text "logs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_accounts", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "postal_code"
    t.string "city"
    t.string "phone"
    t.string "email"
    t.text "preferences"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "robots_allowed", default: false
    t.jsonb "json_attributes"
  end

  create_table "spina_attachment_collections", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spina_attachment_collections_attachments", id: :serial, force: :cascade do |t|
    t.integer "attachment_collection_id"
    t.integer "attachment_id"
  end

  create_table "spina_attachments", id: :serial, force: :cascade do |t|
    t.string "file"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spina_image_collections", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spina_image_collections_images", id: :serial, force: :cascade do |t|
    t.integer "image_collection_id"
    t.integer "image_id"
    t.integer "position"
    t.index ["image_collection_id"], name: "index_spina_image_collections_images_on_image_collection_id"
    t.index ["image_id"], name: "index_spina_image_collections_images_on_image_id"
  end

  create_table "spina_images", force: :cascade do |t|
    t.integer "media_folder_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["media_folder_id"], name: "index_spina_images_on_media_folder_id"
  end

  create_table "spina_layout_parts", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "name"
    t.integer "layout_partable_id"
    t.string "layout_partable_type"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "account_id"
  end

  create_table "spina_line_translations", id: :serial, force: :cascade do |t|
    t.integer "spina_line_id", null: false
    t.string "locale", null: false
    t.string "content"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["locale"], name: "index_spina_line_translations_on_locale"
    t.index ["spina_line_id"], name: "index_spina_line_translations_on_spina_line_id"
  end

  create_table "spina_lines", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "spina_mailinglists", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_mails", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "phone_number", null: false
    t.text "message", null: false
    t.integer "artwork_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_media_folders", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spina_navigation_items", id: :serial, force: :cascade do |t|
    t.integer "page_id"
    t.integer "navigation_id", null: false
    t.integer "position", default: 0, null: false
    t.string "ancestry"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "url"
    t.string "url_title"
    t.string "kind", default: "page", null: false
    t.index ["page_id", "navigation_id"], name: "index_spina_navigation_items_on_page_id_and_navigation_id", unique: true
  end

  create_table "spina_navigations", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "label", null: false
    t.boolean "auto_add_pages", default: false, null: false
    t.integer "position", default: 0, null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["name"], name: "index_spina_navigations_on_name", unique: true
  end

  create_table "spina_options", id: :serial, force: :cascade do |t|
    t.string "value"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spina_page_parts", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "page_id"
    t.integer "page_partable_id"
    t.string "page_partable_type"
  end

  create_table "spina_page_translations", id: :serial, force: :cascade do |t|
    t.integer "spina_page_id", null: false
    t.string "locale", null: false
    t.string "title"
    t.string "menu_title"
    t.string "description"
    t.string "seo_title"
    t.string "materialized_path"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "url_title"
    t.index ["locale"], name: "index_spina_page_translations_on_locale"
    t.index ["spina_page_id"], name: "index_spina_page_translations_on_spina_page_id"
  end

  create_table "spina_pages", id: :serial, force: :cascade do |t|
    t.boolean "show_in_menu", default: true
    t.string "slug"
    t.boolean "deletable", default: true
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "name"
    t.boolean "skip_to_first_child", default: false
    t.string "view_template"
    t.string "layout_template"
    t.boolean "draft", default: false
    t.string "link_url"
    t.string "ancestry"
    t.integer "position"
    t.boolean "active", default: true
    t.integer "resource_id"
    t.jsonb "json_attributes"
    t.integer "ancestry_depth", default: 0
    t.integer "ancestry_children_count"
    t.index ["resource_id"], name: "index_spina_pages_on_resource_id"
  end

  create_table "spina_resources", force: :cascade do |t|
    t.string "name", null: false
    t.string "label"
    t.string "view_template"
    t.string "order_by"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.jsonb "slug"
  end

  create_table "spina_rewrite_rules", id: :serial, force: :cascade do |t|
    t.string "old_path"
    t.string "new_path"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "spina_settings", id: :serial, force: :cascade do |t|
    t.string "plugin"
    t.jsonb "preferences", default: {}
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["plugin"], name: "index_spina_settings_on_plugin"
  end

  create_table "spina_structure_items", id: :serial, force: :cascade do |t|
    t.integer "structure_id"
    t.integer "position"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["structure_id"], name: "index_spina_structure_items_on_structure_id"
  end

  create_table "spina_structure_parts", id: :serial, force: :cascade do |t|
    t.integer "structure_item_id"
    t.integer "structure_partable_id"
    t.string "structure_partable_type"
    t.string "name"
    t.string "title"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["structure_item_id"], name: "index_spina_structure_parts_on_structure_item_id"
    t.index ["structure_partable_id"], name: "index_spina_structure_parts_on_structure_partable_id"
  end

  create_table "spina_structures", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "spina_text_translations", id: :serial, force: :cascade do |t|
    t.integer "spina_text_id", null: false
    t.string "locale", null: false
    t.text "content"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["locale"], name: "index_spina_text_translations_on_locale"
    t.index ["spina_text_id"], name: "index_spina_text_translations_on_spina_text_id"
  end

  create_table "spina_texts", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "spina_users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "last_logged_in", precision: nil
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at", precision: nil
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role", default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "articles", "images", column: "banner_id"
  add_foreign_key "artists", "images", column: "banner_id"
  add_foreign_key "artists", "images", column: "portrait_id"
  add_foreign_key "artworks", "artists"
  add_foreign_key "artworks", "images"
  add_foreign_key "content_images", "content_sections"
  add_foreign_key "content_images", "images"
  add_foreign_key "exhibit_artworks", "artworks"
  add_foreign_key "exhibit_artworks", "exhibits"
  add_foreign_key "exhibits", "images", column: "banner_id"
  add_foreign_key "exhibits", "images", column: "poster_id"
  add_foreign_key "galleries", "images", column: "banner_id"
  add_foreign_key "gallery_artworks", "artworks"
  add_foreign_key "gallery_artworks", "galleries"
end
