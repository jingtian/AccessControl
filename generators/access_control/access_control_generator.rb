class AccessControlGenerator < Rails::Generator::NamedBase
  attr_reader :mode, :args
  
  def initialize(args,runtime_options = {})
    super
    
    mode = args.first.downcase if args.is_a? Array
    case mode
    when 'models'
      @mode = :models
    when 'permission'
      @mode = :permission
    else
      raise 'You must specify what to generate: models or permission'
    end  
    
    @permission_names = args[1..args.size].map { |name| name.underscore.downcase} if args.is_a? Array
    @permission_name = args.second.underscore.downcase if args.is_a? Array and args.size.eql?(2)
    
    @args = args
  end

  def manifest
    record do |m|            
      case mode
      when :models
        # m.directory "lib"
        # m.template 'README', "README"

        m.migration_template File.join("migrate","create_access_control_models.rb"), File.join("db","migrate"), :migration_file_name => "GenerateAccessControlModels".underscore
      when :permission
        file_name = "create_multiple_permissions_#{@permission_names.join('_').underscore}" if args.size > 2
        file_name = "create_permission_#{@permission_name}" if args.size.eql? 2        
        m.migration_template "migration:migration.rb", File.join("db","migrate"), :assigns => migration_options, :migration_file_name => file_name        
      end
    end    
  end
  
  private
  def migration_options
    assigns = {}
    assigns[:migration_action] = "add"
    assigns[:class_name] = "create_multiple_permissions_#{@permission_names.join('_').underscore}".camelize if @permission_names
    assigns[:class_name] = "create_permission_#{@permission_name}" if @permission_name
    assigns[:table_name] = "permissions"
    assigns[:attributes] = @permission_names.map {|name| Rails::Generator::GeneratedAttribute.new(name, "boolean")}
    assigns
  end
end
