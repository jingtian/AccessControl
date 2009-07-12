module AccessControl
  module RoleExtension
    
    def self.included(klass)
      klass.class_eval do
        include AccessControl::CommonMethods
        include AccessControl::Language

        has_and_belongs_to_many :users, :join_table => :user_roles
        has_one :permission, :as => :authorizable, :dependent => :destroy

        alias :has_permission? :has_local_permission?
        alias :can? :has_local_permission?

        accepts_nested_attributes_for :permission
      end
    end

    def permissions
      self.permission.set_permissions
    end

  end
end