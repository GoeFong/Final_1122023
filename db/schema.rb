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

ActiveRecord::Schema[7.0].define(version: 2023_12_14_044044) do
  # These are extensions that must be enabled in order to support this database
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

  create_table "boards", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "prefix_congviec"
    t.integer "row_order"
    t.index ["user_id"], name: "index_boards_on_user_id"
  end

  create_table "congviec_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "congviec_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["congviec_id"], name: "index_congviec_users_on_congviec_id"
    t.index ["user_id"], name: "index_congviec_users_on_user_id"
  end

  create_table "congviecs", force: :cascade do |t|
    t.string "macongviec"
    t.datetime "ngay_bd"
    t.datetime "ngay_kt"
    t.string "diachi"
    t.boolean "status", default: false
    t.bigint "vanban_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "lcongviec_trangthai_id", null: false
    t.integer "row_order"
    t.boolean "them_cb", default: false
    t.bigint "board_id"
    t.string "guest_list"
    t.string "google_event_id"
    t.index ["board_id"], name: "index_congviecs_on_board_id"
    t.index ["lcongviec_trangthai_id"], name: "index_congviecs_on_lcongviec_trangthai_id"
    t.index ["macongviec"], name: "index_congviecs_on_macongviec", unique: true
    t.index ["user_id"], name: "index_congviecs_on_user_id"
    t.index ["vanban_id"], name: "index_congviecs_on_vanban_id"
  end

  create_table "donvi_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "donvi_id", null: false
    t.string "chucvu"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["donvi_id"], name: "index_donvi_users_on_donvi_id"
    t.index ["user_id"], name: "index_donvi_users_on_user_id"
  end

  create_table "donvis", force: :cascade do |t|
    t.string "ten"
    t.string "country"
    t.string "state"
    t.string "city"
    t.string "sdt"
    t.string "email"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forum_categories", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.string "color", default: "000000"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "forum_posts", id: :serial, force: :cascade do |t|
    t.integer "forum_thread_id"
    t.integer "user_id"
    t.text "body"
    t.boolean "solved", default: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "forum_subscriptions", id: :serial, force: :cascade do |t|
    t.integer "forum_thread_id"
    t.integer "user_id"
    t.string "subscription_type"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "forum_threads", id: :serial, force: :cascade do |t|
    t.integer "forum_category_id"
    t.integer "user_id"
    t.string "title", null: false
    t.string "slug", null: false
    t.integer "forum_posts_count", default: 0
    t.boolean "pinned", default: false
    t.boolean "solved", default: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
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

  create_table "lcongviec_trangthais", force: :cascade do |t|
    t.string "label"
    t.string "gia_tri"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "row_order"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "type", null: false
    t.jsonb "params"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name"
    t.string "last_name"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "moderator"
    t.jsonb "roles", default: {}, null: false
    t.string "provider"
    t.string "uid"
    t.string "access_token"
    t.integer "expires_at"
    t.string "refresh_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["roles"], name: "index_users_on_roles", using: :gin
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "vanban_users", force: :cascade do |t|
    t.bigint "vanban_id", null: false
    t.bigint "user_id", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vanban_users_on_user_id"
    t.index ["vanban_id"], name: "index_vanban_users_on_vanban_id"
  end

  create_table "vanbans", force: :cascade do |t|
    t.string "link_to_apply"
    t.string "title"
    t.string "level"
    t.string "loaivanban"
    t.datetime "published_at"
    t.string "status", default: "cho_xu_ly"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.bigint "donvi_id", null: false
    t.index ["donvi_id"], name: "index_vanbans_on_donvi_id"
    t.index ["slug"], name: "index_vanbans_on_slug", unique: true
    t.index ["user_id"], name: "index_vanbans_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "boards", "users"
  add_foreign_key "congviec_users", "congviecs"
  add_foreign_key "congviec_users", "users"
  add_foreign_key "congviecs", "boards"
  add_foreign_key "congviecs", "lcongviec_trangthais"
  add_foreign_key "congviecs", "users"
  add_foreign_key "congviecs", "vanbans"
  add_foreign_key "donvi_users", "donvis", on_delete: :cascade
  add_foreign_key "donvi_users", "users", on_delete: :cascade
  add_foreign_key "forum_posts", "forum_threads"
  add_foreign_key "forum_posts", "users"
  add_foreign_key "forum_subscriptions", "forum_threads"
  add_foreign_key "forum_subscriptions", "users"
  add_foreign_key "forum_threads", "forum_categories"
  add_foreign_key "forum_threads", "users"
  add_foreign_key "vanban_users", "users", on_delete: :cascade
  add_foreign_key "vanban_users", "vanbans", on_delete: :cascade
  add_foreign_key "vanbans", "donvis"
  add_foreign_key "vanbans", "users"
end
