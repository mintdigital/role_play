class RoleAssignment < ActiveRecord::Base
  belongs_to :roleable, :polymorphic => true
  belongs_to :role
  validates_uniqueness_of :role_id, :scope => [:roleable_id, :roleable_type]
  validates_presence_of :roleable_id, :roleable_type, :role_id
end
