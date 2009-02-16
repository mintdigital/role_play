require 'test/unit'
require File.join(File.dirname(__FILE__), 'assertions')
require File.join(File.dirname(__FILE__), %w[.. init.rb])

Test::Unit::TestCase.send :include, ActiveSupport::Testing::Assertions

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3', :dbfile => ':memory:'
)

ActiveRecord::Schema.define(:version => 1) do
  create_table :roleable_samples do |t|
  end

  create_table :roles do |t|
    t.string :name
  end

  create_table :role_assignments do |t|
    t.integer :roleable_id
    t.string :roleable_type
    t.integer :role_id
  end
end
