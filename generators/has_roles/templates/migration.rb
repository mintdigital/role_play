class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name
    end

    create_table :role_assignments do |t|
      t.integer :roleable_id, :role_id
      t.string :roleable_type
    end
  end

  def self.down
    drop_table :role_assignments
    drop_table :roles
  end
end