require 'active_record'
require 'has_roles'
require 'role'
require 'role_assignment'

ActiveRecord::Base.send(:include, HasRoles)

