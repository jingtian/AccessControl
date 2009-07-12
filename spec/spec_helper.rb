ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '/../../../..'
require File.expand_path(File.join(ENV['RAILS_ROOT'], 'config/environment.rb'))

require File.join(File.dirname(__FILE__), '..', 'lib', 'access_control')

require File.join(File.dirname(__FILE__), 'support', 'authorizable')

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => "access_control.sqlite3")

load File.join(File.dirname(__FILE__), 'support', 'schema.rb')