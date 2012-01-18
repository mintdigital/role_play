# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.version = "1.1.3"

  s.name = 'role_play'
  s.summary = %q{Simple roles for ActiveRecord}
  s.description = 'Rails 3-ified version of the beloved plugin'
  s.authors = ["Krzysztof Zylawy", "Mint Digital"]
  s.email = 'hello@mintdigital.com'
  s.homepage = %q{https://github.com/mintdigital/role_play}
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test}/*`.split("\n")
  s.require_paths = ["lib"]
  s.platform = Gem::Platform::RUBY
  s.add_dependency('activerecord', '>= 3.0.3')
  s.add_dependency('railties', '>= 3.0.3')
end
