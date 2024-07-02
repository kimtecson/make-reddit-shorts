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

ActiveRecord::Schema[7.1].define(version: 2024_07_02_125942) do
  create_table "batches", force: :cascade do |t|
    t.integer "source_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_id"], name: "index_batches_on_source_id"
  end

  create_table "outputs", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "source_id", null: false
    t.integer "batch_id", null: false
    t.string "url"
    t.string "src_video"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["batch_id"], name: "index_outputs_on_batch_id"
    t.index ["source_id"], name: "index_outputs_on_source_id"
    t.index ["user_id"], name: "index_outputs_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "output_id", null: false
    t.datetime "publish_time"
    t.string "platform"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["output_id"], name: "index_schedules_on_output_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "url"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sources_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "tiktok_username"
    t.string "ig_username"
    t.string "yt_username"
    t.string "fb_username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "batches", "sources"
  add_foreign_key "outputs", "batches"
  add_foreign_key "outputs", "sources"
  add_foreign_key "outputs", "users"
  add_foreign_key "schedules", "outputs"
  add_foreign_key "sources", "users"
end
