require 'rake'
require 'rake/testtask'
require 'rdoc/task'

desc 'Default: run unit tests.'
task :default => :test

desc 'Default: Run Tests'
Rake::TestTask.new do |t|
  t.warning = true
  t.pattern = 'test/**/*_test.rb'
  t.libs << 'test'
  t.libs << 'lib'
  t.verbose = true
end

desc 'Generate documentation for the role_play plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'RolePlay'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

