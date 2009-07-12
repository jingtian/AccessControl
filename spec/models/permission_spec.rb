require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Permission" do
  it "should be able to clear permissions" do 
    permission = Permission.new
    permission.run_tests = true
    permission.god = true
    permission.post_news = true  
    permission.clear
    permission.run_tests.should be_false
    permission.god.should be_false
    permission.post_news.should be_false
    
  end
  
  describe "Counting Permissions" do
    it "should be empty if no permissions are set" do
      permission = Permission.new
      permission.empty?.should be_true
    end
    
    describe "Set Permissions" do
      it "should return an empty array if none are set" do       
        permission = Permission.new
        permission.set_permissions.should be_a(Array)
        permission.set_permissions.empty?.should be_true 
      end
      
      it "should return an array of set permissions" do
        permission = Permission.new
        permission.run_tests = true
        permission.god = true
        permission.set_permissions.should be_a(Array)
        permission.set_permissions.size.should eql(2)
        permission.set_permissions.include?('run_tests').should be_true
        permission.set_permissions.include?('god').should be_true
      end
    end
  end
end