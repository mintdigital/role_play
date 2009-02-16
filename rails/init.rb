require File.join(File.dirname(__FILE__), %w[.. lib has_roles])

ActiveRecord::Base.send(:include, HasRoles)

