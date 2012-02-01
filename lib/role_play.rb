require 'role'
require 'role_assignment'
require 'active_support/concern'

module RolePlay
  extend ActiveSupport::Concern

  module ClassMethods
    def has_roles(*roles)
      roles.flatten!
      write_inheritable_attribute(:available_roles, roles)
      class_inheritable_reader :available_roles

      has_many :role_assignments, :as => :roleable, :dependent => :destroy
      has_many :roles, :through => :role_assignments

      available_roles.each do |role|
        self.class_eval do
          define_method "#{role}?".to_sym do
            has_role?(role)
          end
        end
      end
    end
  end

  module InstanceMethods
    def can_have_role?(role_name)
      available_roles.include?(role_name)
    end

    def has_role?(rolename)
      self.roles.map(&:name).include?(rolename.to_s)
    end

    def add_role(rolename)
      return false unless can_have_role?(rolename)
      return true if has_role?(rolename)
      self.roles << Role.find_or_create_by_name(rolename.to_s)
    end

    def remove_role(name)
      return true if !has_role?(name)
      role = self.roles.detect { |r| r.name == name.to_s }
      self.roles.delete(role) if role
    end

    def clear_roles
      role_assignments.clear
    end

  end
end

ActiveRecord::Base.send(:include, RolePlay) if defined?(ActiveRecord)
