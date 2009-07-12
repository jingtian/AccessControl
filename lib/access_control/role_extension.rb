module AccessControl
  module RoleExtension
    
    def self.included(klass)
      klass.class_eval do
        include AccessControl::CommonMethods
        include AccessControl::Language

        has_and_belongs_to_many :users, :join_table => :user_roles#, :foreign_key => :access_control_user_id
        has_one :permission, :as => :authorizable, :dependent => :destroy

        alias :has_permission? :has_local_permission?
        alias :can? :has_local_permission?

        accepts_nested_attributes_for :permission
      end
    end

    def permissions
      set = self.permission.set_permissions
      return nil if set.nil?
      return set.first if set.size.eql? 0
      set
    end

  end
end