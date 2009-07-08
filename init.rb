# Include hook code here
%w{ models controllers helpers }.each do |dir|
  path = File.join(directory, 'lib', dir)
  $: << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end

require 'access_control.rb'
