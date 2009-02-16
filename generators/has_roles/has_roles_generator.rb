class HasRolesGenerator < Rails::Generator::Base
  def manifest
    recorded_session = record do |m|
      unless options[:skip_migration]
        m.migration_template "migration.rb", "db/migrate",
          :migration_file_name => 'create_roles'
      end
    end
  end
end
