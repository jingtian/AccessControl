require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Role" do
  before(:each) do
    @valid_attributes = {
      :name => "Role name",
      :description => "Role Description",   
    }
  end

  it "should require a name" do
    role = Role.create(@valid_attributes.except(:name))
    role.should_not be_valid
    role.errors.size.should eql(1)
    role.errors.on(:name).should_not be_nil
  end
  
  it "should require a unique name" do
    Role.create(@valid_attributes)
    
    r = Role.create(@valid_attributes)
    r.should_not be_valid
    r.errors.size.should eql(1)
    r.errors.on(:name).should_not be_nil
  end

  
  it "should only allow descriptions up to 100 characters" do
    @valid_attributes[:description] = "2" * 101
    r = Role.create @valid_attributes
    r.should_not be_valid    
    r.errors.on(:description).should match(/is too long/)
  end    

  it "should create a new instance given valid attributes" do
    Role.destroy_all
    Role.create!(@valid_attributes)
    Role.destroy_all    
  end
  
  it "should always downcase named" do
    r = Role.create(@valid_attributes)
    r.name.should eql(@valid_attributes[:name].downcase)
  end
  

  describe "Permission System" do
    before(:each) do      
      @role = Role.create! @valid_attributes
      @authorizable = @role
    end

    after(:each) do
      @role.destroy
    end
    
    it_should_behave_like "Authorizable"   
  end

end
 