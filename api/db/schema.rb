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

ActiveRecord::Schema[8.1].define(version: 2026_06_29_155935) do
  create_table "albums", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", null: false
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "artists", force: :cascade do |t|
    t.string "comment"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "dee_jays", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "mixcloud_user"
    t.string "name"
    t.string "password_digest"
    t.datetime "updated_at", null: false
  end

  create_table "radio_shows", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", null: false
    t.integer "dee_jay_id"
    t.date "publish_date"
    t.string "title"
    t.datetime "updated_at", null: false
    t.string "web_link"
    t.index ["dee_jay_id"], name: "index_radio_shows_on_dee_jay_id"
  end

  create_table "songs", force: :cascade do |t|
    t.integer "album_id"
    t.integer "artist_id"
    t.string "comment"
    t.datetime "created_at", null: false
    t.integer "last_played_overall_id"
    t.string "title"
    t.integer "total_plays"
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_songs_on_album_id"
    t.index ["artist_id"], name: "index_songs_on_artist_id"
    t.index ["last_played_overall_id"], name: "index_songs_on_last_played_overall_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "ordinal"
    t.integer "radio_show_id"
    t.integer "song_id"
    t.datetime "updated_at", null: false
    t.index ["radio_show_id"], name: "index_tracks_on_radio_show_id"
    t.index ["song_id"], name: "index_tracks_on_song_id"
  end

  add_foreign_key "radio_shows", "dee_jays"
  add_foreign_key "songs", "albums"
  add_foreign_key "songs", "artists"
  add_foreign_key "songs", "radio_shows", column: "last_played_overall_id"
  add_foreign_key "tracks", "radio_shows"
  add_foreign_key "tracks", "songs"
end
