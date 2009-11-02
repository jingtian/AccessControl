module AccessControl
  module ControllerHelper
    def permission_required user, perm
      unless user.has? perm
        flash[:error] = "You do not have permissions in this area."
        redirect_back_or_default
      end
    end

    def role_required(role)

    end
  end
end