require File.join(File.dirname(__FILE__), %w[.. lib role_play])

ActiveRecord::Base.send(:include, RolePlay)

