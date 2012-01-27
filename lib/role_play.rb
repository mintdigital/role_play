require 'role'
require 'role_assignment'
require 'active_support/concern'

module RolePlay
  extend ActiveSupport::Concern

  module ClassMethods
    def has_roles(*roles)
      class_attribute :available_roles
      self.available_roles = roles.flatten

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
      !self.roles.find_by_name(rolename.to_s).nil?
    end

    def add_role rolename
      return false unless can_have_role?(rolename)
      return true if has_role?(rolename)
      self.roles << Role.find_or_create_by_name(rolename.to_s)
      self.save
    end

    def remove_role name
      return true if !has_role?(name)
      role_assignment = self.role_assignments.detect { |x| x.role.name == name.to_s }
      role_assignment.destroy if role_assignment
    end

    def clear_roles
      role_assignments.clear
    end

  end
end

ActiveRecord::Base.send(:include, RolePlay) if defined?(ActiveRecord)
