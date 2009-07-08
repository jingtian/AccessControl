module AccessControl
  module UserExtension
    def self.included(klass)
      klass.class_eval do
          include AccessControl::CommonMethods
          include AccessControl::Language
        
          has_one :permission, :as => :authorizable, :dependent => :destroy						
          has_and_belongs_to_many :roles, :join_table => :user_roles

          alias_method :can? :has_permission?

          #attr_protected :permission_attributes,:role_attributes,:role_ids
          accepts_nested_attributes_for :permission
        end
    end
    
    
    def plays role
      role = role.to_s if role.is_a? Symbol
      r = Role.find_by_name role.downcase
      raise "#{role} does not exist." if r.nil?
      roles << r
      true
    end

    def plays? role
      role = role.to_s if role.is_a? Symbol
      raise "#{role} does not exist" if Role.find_by_name(role.downcase).nil?
      roles.find_by_name(role.downcase) != nil
    end

    def does_not_play? role
      !plays? role
    end

    def has_permission? perm
      return true if has_local_permission? perm
      roles.each do |role|
        return true if role.has_local_permission? perm
      end
      false            
    end

    def permissions        
      set = self.permission.set_permissions
      set = [] if set.nil?
      set = [set] if set.is_a? String        

      role_permissions = []
      roles.each do |role|
        role_perms = role.permission.set_permissions
        role_permissions << role_perms if role_perms.is_a? String
        role_permissions = role_permissions + role_perms if role_perms.is_a? Array
      end

      total = set + role_permissions
      return nil if total.eql? []
      return total.first if total.size.eql? 1
      total.uniq
    end

    def has_any_permissions?
      !self.permissions.nil?
    end      

    def roles_attributes=(attributes)        
      if attributes.size == 1
        self.roles.clear
      else
        keys = []
        attributes.each_key do |id|
          keys << id unless id.to_i.eql? 0
        end
        self.role_ids = keys    
      end
    end
    
  end  
end
