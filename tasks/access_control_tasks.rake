namespace :access_control do
  task :permissions => :environment do
    desc "Lists all available permissions"
    Permission.names.each {|name| puts name}
  end
end