class Permission < ActiveRecord::Base	
	belongs_to :authorizable, :polymorphic => true
	
	def self.names
	  out = []
	  columns.each do |column|
	    out << column.name if column.type == :boolean
    end
    out
  end
  
  def empty?
    Permission.names.each do |name|
      return false if self.send(name.to_sym).eql?(true)
    end
    true
  end
  
  def set_permissions
    set = Permission.names.select {|name| self.send(name.to_sym).eql?(true)}
    return nil if set.eql? []
    return set.first if set.size.eql? 1
    set
  end
  
  def clear
    Permission.names.select {|name| self.update_attribute(name.to_sym,false)}
  end    
end
