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

ActiveRecord::Schema.define(version: 2019_05_18_172935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "citations", force: :cascade do |t|
    t.bigint "question_id"
    t.string "title"
    t.string "author1"
    t.string "author2"
    t.string "author3"
    t.string "author4"
    t.string "author5"
    t.string "publisher"
    t.date "date_of_last_revision"
    t.date "date_of_publication"
    t.date "date_of_retrieval"
    t.string "url"
    t.string "isbn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "source_num"
    t.index ["question_id"], name: "index_citations_on_question_id"
  end

  create_table "coins", force: :cascade do |t|
    t.string "link_name"
    t.string "currency_name"
    t.string "currency_abbrev"
    t.float "volume_usd"
    t.float "volume_btc"
    t.string "picture"
    t.text "question1"
    t.text "question2"
    t.text "question3"
    t.text "question4"
    t.text "question5"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "permalink"
    t.string "genre"
    t.integer "moderator_id"
    t.boolean "accepted", default: false
    t.datetime "accepted_at"
    t.string "founder"
    t.string "country_of_origin"
    t.string "working_product"
    t.boolean "mineable"
    t.string "whitepaper"
    t.string "website"
    t.string "reddit"
    t.string "slack"
    t.string "discord"
    t.string "app"
    t.string "github"
    t.string "tradingview"
    t.string "twitter"
    t.string "facebook"
    t.string "bitcointalk"
    t.string "stackexchange"
    t.string "youtube"
    t.string "coinmarketcap"
    t.string "gitter"
    t.string "blockexplorer"
    t.string "bitfinex"
    t.string "bithumb"
    t.string "bitflyer"
    t.string "hitbtc"
    t.string "kucoin"
    t.string "poloniex"
    t.string "bitstamp"
    t.string "bittrex"
    t.string "gdax"
    t.string "gemini"
    t.string "btcc"
    t.string "kraken"
    t.string "korbit"
    t.string "binance"
    t.string "yorbit"
    t.string "okcoin"
    t.date "date_of_ico"
    t.string "telegram"
    t.string "weibo"
    t.decimal "money_raised_in_ico"
    t.integer "genre_id"
    t.integer "user_id"
    t.integer "coinmarket_id"
    t.text "question6"
    t.text "question7"
    t.text "question8"
    t.text "question9"
    t.text "question10"
    t.string "slug"
    t.boolean "rejected", default: false
    t.boolean "pending", default: true
    t.integer "rank"
    t.decimal "price_usd"
    t.decimal "price_btc"
    t.integer "circulating_supply"
    t.integer "total_supply"
    t.decimal "market_cap"
    t.decimal "percent_change_1h"
    t.decimal "percent_change_24h"
    t.decimal "percent_change_7d"
    t.date "end_of_ico"
    t.integer "active_status", default: 0
    t.index ["active_status"], name: "index_coins_on_active_status"
    t.index ["slug"], name: "index_coins_on_slug", unique: true
  end

  create_table "coins_genres", id: false, force: :cascade do |t|
    t.integer "coin_id"
    t.integer "genre_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "post_id"
    t.text "body"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.integer "parent_id"
    t.integer "upvotes", default: 0
    t.integer "downvotes", default: 0
    t.float "approval_rating", default: 0.0
    t.boolean "deleted", default: false
    t.boolean "edited", default: false
    t.bigint "coin_id"
    t.datetime "deleted_at"
    t.integer "grandparent_id"
    t.index ["coin_id"], name: "index_comments_on_coin_id"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["deleted_at"], name: "index_comments_on_deleted_at"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "editor_files", force: :cascade do |t|
    t.string "file"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.text "content"
    t.datetime "date"
    t.integer "coin_id"
    t.integer "user_id"
    t.boolean "accepted", default: false
    t.integer "upvotes", default: 0
    t.integer "downvotes", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link"
    t.string "picture"
    t.time "time"
    t.string "city"
    t.string "state"
    t.string "country"
    t.text "description"
    t.boolean "rejected", default: false
    t.boolean "pending", default: true
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "venue"
    t.string "street_address"
    t.float "latitude"
    t.float "longitude"
    t.string "zipcode"
    t.datetime "deleted_at"
    t.integer "active_status", default: 0
    t.index ["active_status"], name: "index_events_on_active_status"
    t.index ["deleted_at"], name: "index_events_on_deleted_at"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "coin_id"
    t.integer "user_id"
    t.integer "question_id"
    t.integer "event_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flags", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "question_id"
    t.text "reason_for_flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "post_id"
    t.bigint "coin_id"
    t.index ["coin_id"], name: "index_flags_on_coin_id"
    t.index ["post_id"], name: "index_flags_on_post_id"
    t.index ["question_id"], name: "index_flags_on_question_id"
    t.index ["user_id"], name: "index_flags_on_user_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "coin_id"
    t.string "displayname"
    t.string "slug"
    t.index ["slug"], name: "index_genres_on_slug", unique: true
  end

  create_table "key_players", force: :cascade do |t|
    t.string "title"
    t.text "caption"
    t.text "content"
    t.boolean "accepted", default: false
    t.boolean "rejected", default: false
    t.boolean "pending", default: true
    t.string "image"
    t.text "image_caption"
    t.string "slug"
    t.integer "upvotes", default: 0
    t.integer "downvotes", default: 0
    t.float "approval_rating", default: 0.0
    t.bigint "coin_id"
    t.bigint "user_id"
    t.datetime "accepted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "active_status", default: 0
    t.index ["active_status"], name: "index_key_players_on_active_status"
    t.index ["coin_id"], name: "index_key_players_on_coin_id"
    t.index ["user_id"], name: "index_key_players_on_user_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "url"
    t.integer "coin_id"
    t.integer "user_id"
    t.boolean "accepted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "websitename"
    t.string "tag"
    t.boolean "rejected", default: false
    t.boolean "pending", default: true
    t.boolean "exchange"
    t.text "description"
    t.datetime "deleted_at"
    t.integer "active_status", default: 0
    t.integer "link_type", default: 0
    t.index ["active_status"], name: "index_links_on_active_status"
    t.index ["deleted_at"], name: "index_links_on_deleted_at"
    t.index ["link_type"], name: "index_links_on_link_type"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "actor_id"
    t.datetime "read_at"
    t.string "action"
    t.integer "notifiable_id"
    t.string "notifiable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.string "image"
    t.bigint "coin_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accepted", default: false
    t.boolean "rejected", default: false
    t.boolean "pending", default: true
    t.string "description"
    t.integer "active_status", default: 0
    t.index ["coin_id"], name: "index_pictures_on_coin_id"
    t.index ["user_id"], name: "index_pictures_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.string "url"
    t.string "picture"
    t.integer "coin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "title"
    t.boolean "edited", default: false
    t.integer "upvotes", default: 0
    t.integer "downvotes", default: 0
    t.float "approval_rating", default: 0.0
    t.datetime "deleted_at"
    t.string "post_type"
    t.integer "post_category"
    t.index ["deleted_at"], name: "index_posts_on_deleted_at"
  end

  create_table "question_images", force: :cascade do |t|
    t.string "image"
    t.boolean "accepted", default: false
    t.boolean "pending", default: true
    t.boolean "rejected", default: false
    t.bigint "question_id"
    t.bigint "user_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "top_pic", default: false
    t.text "tags", default: [], array: true
    t.text "tag_string"
    t.index ["question_id"], name: "index_question_images_on_question_id"
    t.index ["user_id"], name: "index_question_images_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "ques_num"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "coin_id"
    t.boolean "accepted", default: false
    t.datetime "accepted_at"
    t.string "term"
    t.text "description"
    t.boolean "rejected", default: false
    t.boolean "pending", default: true
    t.text "caption"
    t.string "image"
    t.text "image_caption"
    t.string "slug"
    t.string "open_topic"
    t.integer "upvotes", default: 0
    t.integer "downvotes", default: 0
    t.float "approval_rating", default: 0.0
    t.datetime "deleted_at"
    t.integer "citation_count", default: 0
    t.integer "active_status", default: 0
    t.index ["active_status"], name: "index_questions_on_active_status"
    t.index ["coin_id"], name: "index_questions_on_coin_id"
    t.index ["deleted_at"], name: "index_questions_on_deleted_at"
    t.index ["ques_num"], name: "index_questions_on_ques_num"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "terms", force: :cascade do |t|
    t.string "title"
    t.text "caption"
    t.text "content"
    t.boolean "accepted", default: false
    t.boolean "pending", default: true
    t.boolean "rejected", default: false
    t.string "image"
    t.text "image_caption"
    t.string "slug"
    t.integer "upvotes", default: 0
    t.integer "downvotes", default: 0
    t.float "approval_rating", default: 0.0
    t.datetime "accepted_at"
    t.bigint "coin_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "active_status", default: 0
    t.index ["active_status"], name: "index_terms_on_active_status"
    t.index ["coin_id"], name: "index_terms_on_coin_id"
    t.index ["user_id"], name: "index_terms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "wallet"
    t.boolean "admin", default: false
    t.boolean "moderator", default: false
    t.integer "currentbalance", default: 0
    t.integer "payout_to_date", default: 0
    t.text "bio"
    t.string "facebook"
    t.string "twitter"
    t.string "instagram"
    t.string "linkedin"
    t.string "youtube"
    t.string "lname"
    t.string "fname"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "id_photo"
    t.string "personal_website"
    t.datetime "deleted_at"
    t.boolean "terms_of_service"
    t.string "authentication_token", limit: 30
    t.integer "newsletter"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  add_foreign_key "citations", "questions"
  add_foreign_key "comments", "coins"
  add_foreign_key "comments", "users"
  add_foreign_key "flags", "coins"
  add_foreign_key "flags", "posts"
  add_foreign_key "flags", "questions"
  add_foreign_key "flags", "users"
  add_foreign_key "key_players", "coins"
  add_foreign_key "key_players", "users"
  add_foreign_key "pictures", "coins"
  add_foreign_key "pictures", "users"
  add_foreign_key "question_images", "questions"
  add_foreign_key "question_images", "users"
  add_foreign_key "terms", "coins"
  add_foreign_key "terms", "users"
end
