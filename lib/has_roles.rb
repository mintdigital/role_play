module HasRoles

  module Version
    MAJOR = 1
    MINOR = 0
    TINY  = 1

    STRING = [MAJOR,MINOR,TINY].join('.')
  end

  def self.included(base)
    base.extend HasMethods
  end

  module HasMethods
    def has_roles(*roles)
      roles.flatten!
      write_inheritable_attribute(:available_roles, roles)
      class_inheritable_reader :available_roles

      unless included_modules.include? InstanceMethods
        has_many :role_assignments, :as => :roleable, :dependent => :destroy
        has_many :roles, :through => :role_assignments

        extend ClassMethods
        include InstanceMethods
        available_roles.each do |role|
          self.class_eval do
            define_method "#{role}?".to_sym do
              has_role?(role)
            end
          end
        end
      end
    end
  end

  module ClassMethods
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
