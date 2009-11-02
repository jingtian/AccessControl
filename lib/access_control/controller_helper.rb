module AccessControl
  module ControllerHelper
#    def permission_required user, perm
#      unless user.has? perm
#        flash[:error] = "You do not have permissions in this area."
#        redirect_back_or_default
#      end
#    end

      def permission_required user, perms #permission
      perms.each do |p|
        unless user.has_permission? p
          permission_denied
        end
      end
    end

    def role_required user, roles   
      roles.each do |role|
        user.does_not_play? role
        permission_denied
      end
    end
    
    def permission_denied
      session[:user_id] = nil
      flash.now[:notice] = "You do not have permissions in this area."
      #      redirect_to :back  
    end
  end
end
