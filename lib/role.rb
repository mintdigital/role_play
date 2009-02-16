class Role < ActiveRecord::Base
  has_many :role_assignments
  has_many :roleables, :through => :role_assignments
  
  validates_uniqueness_of :name, :message => "Role with that name already exists"
end