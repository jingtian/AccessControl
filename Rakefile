require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the access_control plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the access_control plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'AccessControl'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  
  PKG_FILES = FileList[
    '[a-zA-Z]*',
    'generators/**/*',
    'lib/**/*',    
    'tasks/**/*',
    'spec/**/*'
  ]
  
  Jeweler::Tasks.new do |s|
    s.name = "AccessControl"
    s.summary = "Simple role based authorization for rails"
    s.email = "Adman1965@gmail.com"
    s.homepage = "http://github.com/Adman65/AccessControl"
    s.description = "Simple role based authorization for rails"
    s.authors = ["Adam Hawkins"]
    s.files = PKG_FILES.to_a 
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end