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

ActiveRecord::Schema.define(version: 20160229212512) do

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

  create_table "companies", force: :cascade do |t|
    t.string   "name",               limit: 255,                   null: false
    t.string   "city",               limit: 255
    t.string   "state",              limit: 255
    t.string   "country",            limit: 255
    t.text     "url",                limit: 65535
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.boolean  "approved",                         default: false, null: false
    t.string   "slug",               limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "companies", ["slug"], name: "index_companies_on_slug", using: :btree

  create_table "companies_people", force: :cascade do |t|
    t.integer  "person_id",  limit: 4
    t.integer  "company_id", limit: 4
    t.boolean  "approved",             default: false, null: false
    t.boolean  "owner",                default: false, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "companies_people", ["company_id"], name: "index_companies_people_on_company_id", using: :btree
  add_index "companies_people", ["person_id"], name: "index_companies_people_on_person_id", using: :btree

  create_table "companies_podcasts", force: :cascade do |t|
    t.integer  "podcast_id", limit: 4
    t.integer  "company_id", limit: 4
    t.boolean  "approved",             default: false, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "companies_podcasts", ["company_id"], name: "index_companies_podcasts_on_company_id", using: :btree
  add_index "companies_podcasts", ["podcast_id"], name: "index_companies_podcasts_on_podcast_id", using: :btree

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

  create_table "incomings", force: :cascade do |t|
    t.integer  "message_id",   limit: 4
    t.integer  "recipient_id", limit: 4
    t.boolean  "read",                   default: false, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "incomings", ["message_id"], name: "index_incomings_on_message_id", using: :btree
  add_index "incomings", ["recipient_id"], name: "index_incomings_on_recipient_id", using: :btree

  create_table "itunes_reviews", force: :cascade do |t|
    t.integer  "podcast_id",   limit: 4
    t.string   "itunes_id",    limit: 255
    t.string   "author",       limit: 255
    t.string   "title",        limit: 255
    t.text     "content",      limit: 65535
    t.integer  "rating",       limit: 4
    t.datetime "commented_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "itunes_reviews", ["podcast_id"], name: "index_itunes_reviews_on_podcast_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id",  limit: 4
    t.integer  "podcast_id", limit: 4
    t.string   "subject",    limit: 255
    t.text     "body",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "messages", ["podcast_id"], name: "index_messages_on_podcast_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "nominations", force: :cascade do |t|
    t.integer "award_id",   limit: 4
    t.integer "podcast_id", limit: 4
    t.string  "name",       limit: 255
    t.string  "year",       limit: 255
  end

  add_index "nominations", ["award_id"], name: "index_nominations_on_award_id", using: :btree
  add_index "nominations", ["podcast_id"], name: "index_nominations_on_podcast_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "slug",       limit: 255
  end

  add_index "people", ["slug"], name: "index_people_on_slug", using: :btree

  create_table "people_podcasts", force: :cascade do |t|
    t.integer  "person_id",  limit: 4
    t.integer  "podcast_id", limit: 4
    t.text     "position",   limit: 65535
    t.boolean  "approved",                 default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.text     "doc_url",    limit: 65535
  end

  add_index "people_podcasts", ["person_id", "podcast_id"], name: "index_people_podcasts_on_person_id_and_podcast_id", using: :btree

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content",         limit: 65535
    t.integer  "searchable_id",   limit: 4
    t.string   "searchable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plans", force: :cascade do |t|
    t.string  "name",      limit: 255
    t.string  "stripe_id", limit: 255
    t.decimal "price",                 precision: 5, scale: 2
    t.string  "interval",  limit: 255
  end

  create_table "podcast_events", force: :cascade do |t|
    t.integer "podcast_id", limit: 4
    t.string  "ip_address", limit: 255
    t.string  "event",      limit: 255
  end

  add_index "podcast_events", ["podcast_id"], name: "index_podcast_events_on_podcast_id", using: :btree

  create_table "podcast_searches", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "podcast_stats", force: :cascade do |t|
    t.integer  "podcast_id",          limit: 4
    t.integer  "hits",                limit: 4,                         default: 0,   null: false
    t.integer  "unique_hits",         limit: 4,                         default: 0,   null: false
    t.integer  "downloads",           limit: 4,                         default: 0,   null: false
    t.integer  "unique_downloads",    limit: 4,                         default: 0,   null: false
    t.integer  "shares",              limit: 4,                         default: 0,   null: false
    t.integer  "unique_shares",       limit: 4,                         default: 0,   null: false
    t.integer  "itunes_review_count", limit: 4,                         default: 0,   null: false
    t.decimal  "itunes_rating",                 precision: 6, scale: 5, default: 0.0, null: false
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
  end

  add_index "podcast_stats", ["podcast_id"], name: "index_podcast_stats_on_podcast_id", using: :btree

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
    t.boolean  "pcaward",                                                  default: false
    t.boolean  "pcaward2",                                                 default: false
    t.boolean  "pcaward3",                                                 default: false
    t.boolean  "explicit",                                                 default: false
    t.string   "category",           limit: 255
    t.integer  "guest_id",           limit: 4
    t.integer  "cohost_id",          limit: 4
    t.integer  "ppff",               limit: 4
    t.boolean  "approved",                                                 default: false
    t.boolean  "hideplayer",                                               default: false
    t.string   "__awards",           limit: 255
    t.integer  "itunes_id",          limit: 4
    t.boolean  "video"
    t.boolean  "user_approved",                                            default: false
    t.decimal  "score",                            precision: 6, scale: 5, default: 0.0,   null: false
    t.integer  "episodes_count",     limit: 4,                             default: 0
    t.date     "start_date"
    t.string   "slug",               limit: 255
  end

  add_index "podcasts", ["cohost_id"], name: "index_podcasts_on_cohost_id", using: :btree
  add_index "podcasts", ["guest_id"], name: "index_podcasts_on_guest_id", using: :btree
  add_index "podcasts", ["slug"], name: "index_podcasts_on_slug", using: :btree
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

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "plan_id",     limit: 4
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "trial_start"
    t.datetime "trial_end"
    t.string   "status",      limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

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
    t.string   "__first_name",               limit: 255
    t.string   "__last_name",                limit: 255
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
    t.string   "__username",                 limit: 255
    t.string   "membership",                 limit: 255
    t.string   "imdb",                       limit: 255
    t.integer  "person_id",                  limit: 4
    t.string   "customer_id",                limit: 255
    t.string   "card_token",                 limit: 255
    t.datetime "active_until"
    t.string   "provider",                   limit: 255
    t.string   "uid",                        limit: 255
    t.string   "oauth_token",                limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["person_id"], name: "index_users_on_person_id", using: :btree
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

  add_foreign_key "companies_people", "companies"
  add_foreign_key "companies_people", "people"
  add_foreign_key "companies_podcasts", "companies"
  add_foreign_key "companies_podcasts", "podcasts"
  add_foreign_key "incomings", "messages"
  add_foreign_key "incomings", "users", column: "recipient_id"
  add_foreign_key "messages", "podcasts"
  add_foreign_key "messages", "users", column: "sender_id"
end
