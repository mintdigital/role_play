require 'test_helper'
require 'generators/role_play_migration/role_play_migration_generator'

class MigrationGeneratorTest < Rails::Generators::TestCase
  tests RolePlayMigrationGenerator
  destination File.expand_path("../tmp", File.dirname(__FILE__))
  setup :prepare_destination

  test "migration file is created" do
    run_generator
    assert_migration "db/migrate/create_roles.rb" do |mig|
      assert_class_method :up, mig do |upmeth|
        assert_match /create_table/, upmeth
      end
      assert_class_method :down, mig do |downmeth|
        assert_match /drop_table/, downmeth
      end
    end
  end
end