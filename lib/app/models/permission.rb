class Permission < ActiveRecord::Base	
	belongs_to :authorizable, :polymorphic => true
	
	def self.names	  
	  boolean_columns = columns.select { |column| column.type == :boolean}
	  boolean_columns.map { |column| column.name }
  end
  
  def empty?
    set_permissions.empty?
  end
  
  def set_permissions
    Permission.names.select {|name| self.send(name.to_sym).eql?(true)}  
  end
  
  def clear
    Permission.names.select {|name| self.update_attribute(name.to_sym,false)}
  end    
end
