class GenerateAccessControlModels < ActiveRecord::Migration
  def self.up
    create_table "permissions" do |t|
       t.integer  "authorizable_id"
       t.string   "authorizable_type"
       t.datetime "created_at"
       t.datetime "updated_at"
    end
    
    create_table "roles" do |t|
      t.string   "name"
      t.string   "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    create_table "user_roles", :id => false  do |t|
      t.integer "user_id"
      t.integer "role_id"
    end
  end
  
  def self.down
    drop_table :permisisons
    drop_table :roles
    drop_table :user_roles
  end
end