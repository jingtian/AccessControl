require '../lib/access_control'

class User < ActiveRecord::Base
  has_access_controls
end
