require 'test_helper'

class ValidatedRoleable < ActiveRecord::Base
  has_roles :sample_role_1, :sample_role_2

  validates :test_attr, :presence => true
end

class InvalidRecordRolePlayTest < ActiveSupport::TestCase
  def setup
    @record = ValidatedRoleable.new
    assert !@record.valid?, "Precondition: record not valid"
  end

  def teardown
    [Role, RoleAssignment, ValidatedRoleable].each {|klass| klass.delete_all }
  end

  def test_should_add_role_to_new_record
    assert_difference "@record.roles.size", 1 do
      @record.add_role(:sample_role_1)
    end
  end

  # test that role? works on new records
  def test_should_know_state_of_role_on_new_record
    assert !@record.sample_role_1?, "Precondition: ? method is false"
    @record.add_role(:sample_role_1)
    assert @record.sample_role_1?, "? method should be correct now"
  end

  def test_should_save_association_when_saving_new_record
    @record.add_role(:sample_role_1)
    assert_equal 0, RoleAssignment.count, "nothing saved to DB yet"

    @record.test_attr = 'foo'
    assert @record.save, "save should succeed now"
    assert_equal 1, RoleAssignment.count, "role assignment should save to DB"
  end

  def test_should_autosave_when_record_not_new_and_valid
    @record.test_attr = 'foo'
    assert @record.save, 'Precondition: record valid & saved'
    assert_difference "RoleAssignment.count", 1 do
      @record.add_role(:sample_role_1)
    end
  end

  def test_should_autosave_when_record_not_new_and_ivalid
    @record.test_attr = 'foo'
    assert @record.save, 'Precondition: record valid'
    @record.test_attr = nil
    assert !@record.valid?, 'Precondition: back to an invalid state'
    assert_difference "RoleAssignment.count", 1 do
      @record.add_role(:sample_role_1)
    end
  end
end