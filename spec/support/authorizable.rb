shared_examples_for "Authorizable" do
  describe "DSL" do
    it "should have method in the format of can_permission_name? to ask permission" do      
      Permission.names.each do |permission|
        method_name = ("can_" + permission.downcase + "?").to_sym
        @authorizable.send(method_name)
      end
    end

    it "should have a method formatted like can_not_permission? to see if denied" do
      Permission.names.each do |permission|
        method_name = ("can_not_" + permission.downcase + "?").to_sym
        @authorizable.send(method_name)
      end
    end

    it "should raise an error when asking can_permission_that_deoesnt_exist" do
      lambda{ @authorizable.can_permission_that_has_no_chance_of_existing?}.should raise_error
    end

    it "should also raise an error when asking can_not?" do
      lambda{ @authorizable.can_not_permission_that_has_no_chance_of_existing?}.should raise_error
    end
  end

  describe "Granting a permission" do
    it "should have a method to grant a permission" do
      @authorizable.respond_to?(:grant).should be_true
    end

    it "should take a symbol as a permission name" do        
      lambda {@authorizable.grant(:manage_users)}.should_not raise_error
    end

    it "should take a string as a permission name" do
      lambda { @authorizable.grant("manage_users")}.should_not raise_error
    end

    it "should raise an error if the permission is not a string or symbol" do
      lambda { @authorizable.grant([:permission, :permission])}.should raise_error
    end

    it "should only grant permissions that exist" do
      @authorizable.grant(:manage_news).should be_true
    end

    it "should raise an error when permissions don't exist" do
      lambda { @authorizable.grant(:adsfjk238748723478)}.should raise_error
    end

    it "should be able to authorize after granting" do
      @authorizable.can?(:manage_news).should be_false
      @authorizable.grant(:manage_news).should be_true
      @authorizable.can?(:manage_news).should be_true
    end

    it "should have a method to check to see if it is god" do
      @authorizable.respond_to?(:god?).should be_true
    end      
  end
end