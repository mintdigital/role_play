require 'test_helper'
require 'generators/role_play_migration/role_play_migration_generator'

class MigrationGeneratorTest < Rails::Generators::TestCase
  tests RolePlayMigrationGenerator
  destination File.expand_path("../tmp", File.dirname(__FILE__))
  setup :prepare_destination
  
  test "migration file is created" do
    run_generator
    assert_migration "db/migrate/create_roles.rb"
  end
end