require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require File.join(File.dirname(__FILE__), %w[lib/role_play])

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "role_play"
    s.summary = "Simple roles for ActiveRecord"
    s.email = "hello@mintdigital.com"
    s.homepage = "http://github.com/mintdigital/role_play"
    s.authors = ["Krzysztof Zylawy", "Mint Digital"]
    s.add_dependency 'activerecord'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install jeweler"
end


desc 'Default: Run Tests'
Rake::TestTask.new do |t|
  t.warning = true
  t.pattern = 'test/**/*_test.rb'
end

desc 'Generate documentation for the role_play plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'RolePlay'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
