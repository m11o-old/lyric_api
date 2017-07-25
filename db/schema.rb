# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170725115515) do

  create_table "access_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "access_at", null: false
    t.bigint "music_info_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "artist_name", null: false
    t.string "composer"
    t.string "lyricist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lyrics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "music_information_id", null: false
    t.text "lyric", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "music_informations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "artist_id", null: false
    t.string "music_name", null: false
    t.string "lyric_type", default: "japanese"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rankings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "term", default: "day", null: false
    t.bigint "music_info_id_on_rank0"
    t.string "movie_url_on_rank0"
    t.bigint "music_info_id_on_rank1"
    t.string "movie_url_on_rank1"
    t.bigint "music_info_id_on_rank2"
    t.string "movie_url_on_rank2"
    t.bigint "music_info_id_on_rank3"
    t.string "movie_url_on_rank3"
    t.bigint "music_info_id_on_rank4"
    t.string "movie_url_on_rank4"
    t.bigint "music_info_id_on_rank5"
    t.string "movie_url_on_rank5"
    t.bigint "music_info_id_on_rank6"
    t.string "movie_url_on_rank6"
    t.bigint "music_info_id_on_rank7"
    t.string "movie_url_on_rank7"
    t.bigint "music_info_id_on_rank8"
    t.string "movie_url_on_rank8"
    t.bigint "music_info_id_on_rank9"
    t.string "movie_url_on_rank9"
    t.date "ranked_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "translation_lyrics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "lyric_id", null: false
    t.string "lyric_type", default: "english"
    t.text "trans_lyric", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
