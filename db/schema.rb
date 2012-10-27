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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121027145425) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_user_teams", :force => true do |t|
    t.integer "admin_user_id"
    t.integer "team_id"
  end

  add_index "admin_user_teams", ["admin_user_id", "team_id"], :name => "index_admin_user_teams_on_admin_user_id_and_team_id"

  create_table "admin_users", :force => true do |t|
    t.integer  "entity_id"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "fullname",               :default => "", :null => false
    t.string   "phone",                  :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["entity_id"], :name => "index_admin_users_on_entity_id"
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "admin_users_roles", :id => false, :force => true do |t|
    t.integer "admin_user_id"
    t.integer "role_id"
  end

  add_index "admin_users_roles", ["admin_user_id", "role_id"], :name => "index_admin_users_roles_on_admin_user_id_and_role_id"

  create_table "entities", :force => true do |t|
    t.string   "kode",           :default => ""
    t.string   "entitas",        :default => ""
    t.string   "kota",           :default => ""
    t.string   "alamat",         :default => ""
    t.string   "phone",          :default => ""
    t.string   "fax",            :default => ""
    t.string   "status",         :default => ""
    t.string   "keterangan",     :default => ""
    t.string   "kepala_entitas", :default => ""
    t.string   "kecamatan",      :default => ""
    t.string   "kabupaten",      :default => ""
    t.string   "provinsi",       :default => ""
    t.integer  "wilayah",                        :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "examinations", :force => true do |t|
    t.integer  "lhp_id"
    t.string   "uraian",               :default => ""
    t.string   "rekomendasi",          :default => ""
    t.string   "tanggapan",            :default => ""
    t.string   "status",               :default => "Diinput"
    t.string   "created_by",           :default => ""
    t.string   "updated_by",           :default => ""
    t.string   "accepted_by",          :default => ""
    t.string   "rejected_by",          :default => ""
    t.datetime "accepted_at"
    t.datetime "rejected_at"
    t.integer  "priority"
    t.text     "catatan_pengembalian"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "examinations", ["lhp_id"], :name => "index_examinations_on_lhp_id"

  create_table "lhps", :force => true do |t|
    t.integer  "entity_id"
    t.integer  "work_plan_id"
    t.string   "keterangan",           :default => ""
    t.string   "pre_keterangan",       :default => ""
    t.string   "post_keterangan",      :default => ""
    t.datetime "tanggal_awal"
    t.datetime "tanggal_akhir"
    t.string   "status",               :default => "Diinput"
    t.string   "updated_by",           :default => ""
    t.string   "created_by",           :default => ""
    t.string   "accepted_by",          :default => ""
    t.text     "catatan_pengembalian"
    t.datetime "accepted_at"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.text     "program_pemeriksaan"
    t.text     "maksud_tujuan"
  end

  add_index "lhps", ["entity_id", "work_plan_id"], :name => "lhp_entity_work_plan"

  create_table "pkpt_recapitulations", :force => true do |t|
    t.integer  "pkpt_id"
    t.integer  "recapitulation_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "pkpt_recapitulations", ["pkpt_id", "recapitulation_id"], :name => "index_pkpt_recapitulations_on_pkpt_id_and_recapitulation_id"

  create_table "pkpts", :force => true do |t|
    t.integer  "entity_id"
    t.string   "keterangan",           :default => ""
    t.string   "periode"
    t.string   "status",               :default => "Diinput"
    t.string   "created_by",           :default => ""
    t.string   "updated_by",           :default => ""
    t.string   "accepted_by",          :default => ""
    t.string   "rejected_by",          :default => ""
    t.datetime "accepted_at"
    t.datetime "rejected_at"
    t.integer  "tipe",                 :default => 0
    t.text     "catatan_pengembalian"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.text     "notes"
    t.string   "wilayah",              :default => ""
  end

  add_index "pkpts", ["entity_id"], :name => "index_pkpts_on_entity_id"

  create_table "recapitulations", :force => true do |t|
    t.string   "periode",            :default => ""
    t.text     "keterangan_pembuka"
    t.text     "keterangan_penutup"
    t.string   "status_rekap",       :default => "Belum Rekap"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.string   "keterangan"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "teams", :force => true do |t|
    t.integer  "work_plan_id"
    t.integer  "leader_id"
    t.string   "name",         :default => ""
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "teams", ["work_plan_id"], :name => "index_teams_on_work_plan_id"

  create_table "work_plan_categories", :force => true do |t|
    t.string   "name",        :default => ""
    t.string   "description", :default => ""
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "work_plans", :force => true do |t|
    t.integer  "work_plan_category_id"
    t.integer  "pkpt_id"
    t.integer  "team_id"
    t.text     "catatan_pengembalian"
    t.string   "status",                :default => "Diinput"
    t.string   "created_by",            :default => ""
    t.string   "updated_by",            :default => ""
    t.string   "accepted_by",           :default => ""
    t.string   "rejected_by",           :default => ""
    t.datetime "accepted_at"
    t.datetime "rejected_at"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "description",           :default => ""
    t.text     "work_plan_details"
    t.integer  "created_by_id"
  end

  add_index "work_plans", ["work_plan_category_id", "pkpt_id", "team_id"], :name => "work_plan_cat_lhp_team"

end
