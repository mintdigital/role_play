class HasRolesGenerator < Rails::Generator::NamedBase
  def manifest
      recorded_session = record do |m| 
        unless options[:skip_migration] 
          m.migration_template "migration.rb", "db/migrate" 
        end 
      end
  end
end
