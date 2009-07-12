#require '../access_control'

class Role < ActiveRecord::Base
	include AccessControl::RoleExtension
	
	validates_presence_of :name
	validates_uniqueness_of :name
	
	validates_length_of :description, :maximum => 100, :allow_nil => true
  
  def before_validation
    self.name = self.name.downcase unless self.name.nil?
  end
end
