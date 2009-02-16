# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{has_roles}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Krzysztof Zylawy"]
  s.date = %q{2009-02-16}
  s.description = %q{Simple roles for ActiveRecord}
  s.email = %q{krzysztof@mintdigital.com}
  s.extra_rdoc_files = ["lib/has_roles.rb", "lib/role.rb", "lib/role_assignment.rb", "README", "tasks/has_roles_tasks.rake"]
  s.files = ["generators/has_roles/has_roles_generator.rb", "generators/has_roles/templates/migration.rb", "generators/has_roles/USAGE", "has_roles.gemspec", "install.rb", "lib/has_roles.rb", "lib/role.rb", "lib/role_assignment.rb", "Manifest", "MIT-LICENSE", "rails/init.rb", "Rakefile", "README", "tasks/has_roles_tasks.rake", "test/assertions.rb", "test/has_roles_test.rb", "test/test_helper.rb", "uninstall.rb"]
  s.homepage = %q{}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Has_roles", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{has_roles}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Simple roles for ActiveRecord}
  s.test_files = ["test/has_roles_test.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 0"])
      s.add_development_dependency(%q<echoe>, [">= 0"])
    else
      s.add_dependency(%q<activerecord>, [">= 0"])
      s.add_dependency(%q<echoe>, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 0"])
    s.add_dependency(%q<echoe>, [">= 0"])
  end
end
