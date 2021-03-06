# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_23_064019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "topic_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["topic_id", "user_id"], name: "index_comments_on_topic_id_and_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "oauth_identities", force: :cascade do |t|
    t.string "uid"
    t.string "provider"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "provider"], name: "index_oauth_identities_on_user_id_and_provider", unique: true
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "topic_id", null: false
    t.bigint "user_id", null: false
    t.integer "report_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "topic_id"], name: "index_reports_on_user_id_and_topic_id", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "topics_count", default: 0, null: false
    t.string "slug"
    t.string "text_color", default: "#FFFFFF", null: false
    t.string "background_color", default: "#17a2b8", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
    t.index ["slug"], name: "index_tags_on_slug", unique: true
  end

  create_table "topic_tags", force: :cascade do |t|
    t.bigint "topic_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["topic_id", "tag_id"], name: "index_topic_tags_on_topic_id_and_tag_id", unique: true
  end

  create_table "topic_votes", force: :cascade do |t|
    t.integer "vote"
    t.bigint "topic_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["topic_id", "user_id"], name: "index_topic_votes_on_topic_id_and_user_id", unique: true
  end

  create_table "topics", force: :cascade do |t|
    t.string "title", null: false
    t.integer "visibility", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "creator_id", null: false
    t.text "description_excerpt"
    t.bigint "reports_count", default: 0, null: false
    t.index ["creator_id"], name: "index_topics_on_creator_id"
    t.index ["title"], name: "index_topics_on_title_trigram", opclass: :gin_trgm_ops, using: :gin
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.integer "role", default: 0
    t.integer "status", default: 0
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
    t.index ["status"], name: "index_users_on_status"
  end

  create_table "viewers", force: :cascade do |t|
    t.bigint "topic_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["topic_id", "user_id"], name: "index_viewers_on_topic_id_and_user_id", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "topics", on_update: :cascade, on_delete: :cascade
  add_foreign_key "comments", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "oauth_identities", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "reports", "topics", on_update: :cascade, on_delete: :cascade
  add_foreign_key "reports", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "topic_tags", "tags", name: "topic_tags_tag_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "topic_tags", "topics", name: "topic_tags_topic_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "topic_votes", "topics", name: "topic_votes_topic_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "topic_votes", "users", name: "topic_votes_user_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "topics", "users", column: "creator_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "viewers", "topics", name: "viewers_topic_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "viewers", "users", name: "viewers_user_id_fk", on_update: :cascade, on_delete: :cascade
end
