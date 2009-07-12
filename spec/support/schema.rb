ActiveRecord::Schema.define do
  create_table "permissions", :force => true do |t|
    t.integer  "authorizable_id"
    t.string   "authorizable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "run_tests",           :default => false
    t.boolean  "post_news", :default => false
    t.boolean   "manage_news", :default => false
    t.boolean "manage_users", :default => false
    t.boolean  "god",                   :default => false
    t.boolean  "manage_events",         :default => false
    t.boolean "manage_schedule", :default => false
  end
  
  create_table "role_permissions", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "permission_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  
  create_table "user_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end
  
  create_table "users", :force => true do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  
end