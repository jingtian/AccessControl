# AccessControl

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