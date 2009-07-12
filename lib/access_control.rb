# AccessControl

require File.join(File.dirname(__FILE__), 'access_control', 'user_extension')
require File.join(File.dirname(__FILE__), 'access_control', 'controller_helper')
require File.join(File.dirname(__FILE__), 'access_control', 'common_methods')
require File.join(File.dirname(__FILE__), 'access_control', 'language')
require File.join(File.dirname(__FILE__), 'access_control', 'role_extension')

%w{ models }.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end

module AccessControl
  module MacroMethods
    def self.included base
      base.extend ClassMethods
    end


    module ClassMethods
      def has_access_controls
        include AccessControl::UserExtension  
      end
    end
  end
end


ActiveRecord::Base.send :include, AccessControl::MacroMethods
ActionController::Base.send :include, AccessControl::ControllerHelper