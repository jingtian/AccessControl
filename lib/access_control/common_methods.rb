module AccessControl
  module CommonMethods      

    def self.included(klass)
      klass.class_eval do
        alias :authorize :grant
      end
    end

    def grant(perm)
      self.permission = Permission.create if self.permission.nil?
      perm = perm.to_s if perm.is_a? Symbol
      raise "Permission (#{perm}) does not exist" unless self.permission.respond_to? perm.to_sym
      self.permission.update_attribute(perm,true)
    end

    def deauthorize perm
      self.permission = Permission.create if self.permission.nil?
      perm = perm.to_s if perm.is_a? Symbol
      raise "Permission (#{perm}) does not exist" unless self.permission.respond_to? perm.to_sym
      self.permission.update_attribute(perm,false)
    end

    def cannot? perm
      !has_permission? perm
    end

    def god?
      has_permission? :god
    end

    def has_local_permission? perm  	    
      perm = perm.to_s if perm.is_a? Symbol
      raise "Permission (#{perm}) does not exist" unless Permission.new.respond_to? perm.to_sym
      return false if self.permission.nil?
      return true if self.permission.god
      self.permission.send(perm)  
    end

    private
    def create_new_permission
      self.permission = Permission.create
    end

  end
end