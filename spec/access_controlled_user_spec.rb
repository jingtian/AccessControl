require 'spec_helper'
require 'support/access_control_user'

describe "User with access controls" do
  before(:each) do
    @authorizable = User.new
    @user = @authorizable
    @admin_role = Role.create!(:name => "admin")
  end
  
  after(:each) do
    @admin_role.destroy
  end
  
  it_should_behave_like "Authorizable"
  
  describe "Working with Roles" do
    it "should be a role after granting a role" do
      lambda {@user.plays?(:rspec)}.should raise_error
      r = Role.create! :name => "Rspec", :description => "runs rspec tests"
      @user.plays("Rspec").should be_true
      @user.plays?(:rspec).should be_true
    end

    it "should raise an error when setting a role that doesn't exsist" do
      lambda {@user.plays(:fake_role)}.should raise_error
    end
    
    it "should raise an error when asking if a user plays a role that doesn't exist" do
      lambda {@user.plays?(:fake_role)}.should raise_error
    end
  end

  describe "Checking Authorization" do
    it "should authorize god users on any permission" do  
      @user.can?(:manage_news).should be_false
      @user.grant(:god).should be_true        
      Permission.names.each {|name| @user.can?(name).should be_true}
    end

    it "should authorize if the user the permission through a role" do
      @user.can_manage_news?.should be_false
      @admin_role.can_manage_news?.should be_false
      @user.plays(:admin).should be_true
      @admin_role.grant(:manage_news).should be_true
      @user.can_manage_news?.should be_true

      @user.roles.clear
      @user.can_manage_news?.should be_false        
    end

    it "should authorize if the user has permission through his permissions" do
      @user.can_manage_schedule?.should be_false
      @user.grant(:manage_schedule).should be_true
      @user.can_manage_schedule?.should be_true        
    end

    it "should be able to check access denied" do
      @user.permission = nil
      @user.roles.clear
      @user.can_not_manage_schedule?.should be_true
    end
  end   
  
  describe "Counting total permissions" do
    it "should have permissions if they belong to the user" do
      @user.has_any_permissions?.should be_false
      @user.permissions.empty?.should be_true
      @user.grant :manage_news
      @user.permissions.should_not be_nil
      @user.permissions.should eql(['manage_news'])
      @user.has_any_permissions?.should be_true
    end

    it "should have permissions through roles" do
      @user.has_any_permissions?.should be_false
      @user.grant :manage_news
      @admin_role.grant :manage_schedule
      @user.plays :admin
      @user.permissions.should be_a(Array)
      @user.permissions.size.should eql(2)
      @user.permissions.include?('manage_schedule').should be_true
      @user.permissions.include?('manage_news').should be_true
      @user.has_any_permissions?.should be_true
      
      @user.permission.clear
      @user.permissions.should be_a(Array)
      @user.permissions.should eql(['manage_schedule'])
    end
  end
end