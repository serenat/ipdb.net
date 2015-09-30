# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150930143331) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "awards", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content",          limit: 65535
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commontator_comments", force: :cascade do |t|
    t.string   "creator_type",       limit: 255
    t.integer  "creator_id",         limit: 4
    t.string   "editor_type",        limit: 255
    t.integer  "editor_id",          limit: 4
    t.integer  "thread_id",          limit: 4,                 null: false
    t.text     "body",               limit: 65535,             null: false
    t.datetime "deleted_at"
    t.integer  "cached_votes_total", limit: 4,     default: 0
    t.integer  "cached_votes_up",    limit: 4,     default: 0
    t.integer  "cached_votes_down",  limit: 4,     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_comments", ["cached_votes_down"], name: "index_commontator_comments_on_cached_votes_down", using: :btree
  add_index "commontator_comments", ["cached_votes_total"], name: "index_commontator_comments_on_cached_votes_total", using: :btree
  add_index "commontator_comments", ["cached_votes_up"], name: "index_commontator_comments_on_cached_votes_up", using: :btree
  add_index "commontator_comments", ["creator_id", "creator_type", "thread_id"], name: "index_c_c_on_c_id_and_c_type_and_t_id", using: :btree
  add_index "commontator_comments", ["thread_id"], name: "index_commontator_comments_on_thread_id", using: :btree

  create_table "commontator_subscriptions", force: :cascade do |t|
    t.string   "subscriber_type", limit: 255,             null: false
    t.integer  "subscriber_id",   limit: 4,               null: false
    t.integer  "thread_id",       limit: 4,               null: false
    t.integer  "unread",          limit: 4,   default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_subscriptions", ["subscriber_id", "subscriber_type", "thread_id"], name: "index_c_s_on_s_id_and_s_type_and_t_id", unique: true, using: :btree
  add_index "commontator_subscriptions", ["thread_id"], name: "index_commontator_subscriptions_on_thread_id", using: :btree

  create_table "commontator_threads", force: :cascade do |t|
    t.string   "commontable_type", limit: 255
    t.integer  "commontable_id",   limit: 4
    t.datetime "closed_at"
    t.string   "closer_type",      limit: 255
    t.integer  "closer_id",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_threads", ["commontable_id", "commontable_type"], name: "index_c_t_on_c_id_and_c_type", unique: true, using: :btree

  create_table "episodes", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "source",     limit: 255
    t.string   "url",        limit: 255
    t.text     "summary",    limit: 65535
    t.integer  "podcast_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "followable_id",   limit: 4,                   null: false
    t.string   "followable_type", limit: 255,                 null: false
    t.integer  "follower_id",     limit: 4,                   null: false
    t.string   "follower_type",   limit: 255,                 null: false
    t.boolean  "blocked",                     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "provider",    limit: 255
    t.string   "uid",         limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "oauth_token", limit: 255
    t.boolean  "shared",                  default: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "nominations", force: :cascade do |t|
    t.integer "award_id",   limit: 4
    t.integer "podcast_id", limit: 4
    t.string  "name",       limit: 255
    t.string  "year",       limit: 255
  end

  add_index "nominations", ["award_id"], name: "index_nominations_on_award_id", using: :btree
  add_index "nominations", ["podcast_id"], name: "index_nominations_on_podcast_id", using: :btree

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content",         limit: 65535
    t.integer  "searchable_id",   limit: 4
    t.string   "searchable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "podcast_searches", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "podcasts", force: :cascade do |t|
    t.string   "description",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",            limit: 4
    t.text     "name",               limit: 65535
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.string   "image_url",          limit: 255
    t.string   "episodes_url",       limit: 255
    t.boolean  "pcaward",                          default: false
    t.boolean  "pcaward2",                         default: false
    t.boolean  "pcaward3",                         default: false
    t.boolean  "explicit",                         default: false
    t.string   "category",           limit: 255
    t.integer  "guest_id",           limit: 4
    t.integer  "cohost_id",          limit: 4
    t.integer  "ppff",               limit: 4
    t.boolean  "approved",                         default: false
    t.boolean  "hideplayer",                       default: false
    t.string   "__awards",           limit: 255
    t.integer  "itunes_id",          limit: 4
    t.boolean  "video"
    t.boolean  "user_approved",                    default: false
  end

  add_index "podcasts", ["cohost_id"], name: "index_podcasts_on_cohost_id", using: :btree
  add_index "podcasts", ["guest_id"], name: "index_podcasts_on_guest_id", using: :btree
  add_index "podcasts", ["user_id"], name: "index_podcasts_on_user_id", using: :btree

  create_table "rates", force: :cascade do |t|
    t.integer  "rater_id",      limit: 4
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.float    "stars",         limit: 24,  null: false
    t.string   "dimension",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id", using: :btree

  create_table "rating_caches", force: :cascade do |t|
    t.integer  "cacheable_id",   limit: 4
    t.string   "cacheable_type", limit: 255
    t.float    "avg",            limit: 24,  null: false
    t.integer  "qty",            limit: 4,   null: false
    t.string   "dimension",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree

  create_table "user_podcasts", force: :cascade do |t|
    t.integer  "podcast_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "position",   limit: 65535
    t.boolean  "approved",                 default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                      limit: 255,   default: "", null: false
    t.string   "encrypted_password",         limit: 255,   default: "", null: false
    t.string   "reset_password_token",       limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",              limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",         limit: 255
    t.string   "last_sign_in_ip",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",                 limit: 255
    t.string   "last_name",                  limit: 255
    t.text     "description",                limit: 65535
    t.string   "profile_image_file_name",    limit: 255
    t.string   "profile_image_content_type", limit: 255
    t.integer  "profile_image_file_size",    limit: 4
    t.datetime "profile_image_updated_at"
    t.string   "facebook",                   limit: 255
    t.string   "twitter",                    limit: 255
    t.string   "pinterest",                  limit: 255
    t.string   "instagram",                  limit: 255
    t.string   "linkedin",                   limit: 255
    t.text     "about",                      limit: 65535
    t.text     "work",                       limit: 65535
    t.text     "education",                  limit: 65535
    t.string   "username",                   limit: 255
    t.string   "membership",                 limit: 255
    t.string   "imdb",                       limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id",   limit: 4
    t.string   "votable_type", limit: 255
    t.integer  "voter_id",     limit: 4
    t.string   "voter_type",   limit: 255
    t.boolean  "vote_flag"
    t.string   "vote_scope",   limit: 255
    t.integer  "vote_weight",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

  add_foreign_key "identities", "users"
end
