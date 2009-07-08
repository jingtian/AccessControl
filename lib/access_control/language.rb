module AccessControl
  module Language
  
    def method_missing(method_id, *attrs)	     
      if /can_not_(.+)\?/.match(method_id.to_s)
        return !has_permission?($~[1])
      elsif /can_(.+)\?/.match(method_id.to_s)
        return has_permission?($~[1])          
        #elsif /is_(.+)\?/.match(method_id.to_s)
        #return true if has_permission? :god
        #return !roles.find_by_name($~[1]).nil?			  
      else
        super		      
      end
    end    

  end
end