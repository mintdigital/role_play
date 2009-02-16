require File.join(File.dirname(__FILE__), 'test_helper')

class RoleableSample < ActiveRecord::Base
  has_roles [:sample_role_1, :sample_role_2]
end

class HasRolesTest < Test::Unit::TestCase

  def setup
    @roleable_sample = RoleableSample.create
  end

  def teardown
    [Role, RoleAssignment, RoleableSample].each {|klass| klass.delete_all }
  end

  def test_active_record_should_respond_to_has_roles
    assert ActiveRecord::Base.respond_to?(:has_roles)
  end

  def test_roleable_class_should_return_available_roles
    assert_equal [:sample_role_1, :sample_role_2], RoleableSample.available_roles
  end

  def test_roleable_object_can_have_its_class_roles
    [:sample_role_1, :sample_role_2].each do |role_name|
      assert_equal(true, @roleable_sample.can_have_role?(role_name))
    end
  end

  def test_should_be_able_to_add_valid_role_to_roleable
    assert_difference "RoleAssignment.count", 1 do
      assert_difference "Role.count", 1 do
        @roleable_sample.add_role(:sample_role_1)
      end
    end
  end

  def test_should_return_true_when_role_added
    assert @roleable_sample.add_role(:sample_role_1)
  end

  def test_should_not_be_able_to_add_invalid_role_to_roleable
    assert_no_difference "RoleAssignment.count", 1 do
      assert_no_difference "Role.count", 1 do
        @roleable_sample.add_role(:invalid_role)
      end
    end
    assert_equal(false, @roleable_sample.has_role?(:invalid_role))
  end

  def test_should_return_false_when_invalid_role_not_added
    assert !@roleable_sample.add_role(:invalid_role)
  end

  def test_should_not_add_role_nor_assignment_if_already_has_role
    @roleable_sample.add_role(:sample_role_1)
    assert_no_difference "RoleAssignment.count" do
      assert_no_difference "Role.count" do
        @roleable_sample.add_role(:sample_role_1)
      end
    end
    assert_equal(true, @roleable_sample.has_role?(:sample_role_1))
  end

  def test_should_return_true_if_already_has_role
    @roleable_sample.add_role(:sample_role_1)
    assert @roleable_sample.has_role?(:sample_role_1), 'Precondition: has role'
    assert @roleable_sample.add_role(:sample_role_1)
  end

  def test_should_add_assignment_but_not_role_nor_assignment_if_role_exists
    Role.create(:name => 'sample_role_1')
    assert_difference "RoleAssignment.count", 1 do
      assert_no_difference "Role.count" do
        @roleable_sample.add_role(:sample_role_1)
      end
    end
    assert_equal(true, @roleable_sample.has_role?(:sample_role_1))
  end

  def test_should_have_added_role
    @roleable_sample.add_role(:sample_role_1)
    assert_equal(true, @roleable_sample.has_role?(:sample_role_1))
  end

  def test_should_not_have_not_added_role
    @roleable_sample.add_role(:sample_role_1)
    assert_equal(false, @roleable_sample.has_role?(:sample_role_2))
  end

  def test_should_remove_role_assignment
    @roleable_sample.add_role(:sample_role_1)
    assert_difference "RoleAssignment.count", -1 do
      assert_no_difference "Role.count" do
        @roleable_sample.remove_role(:sample_role_1)
      end
    end
    assert_equal(false, @roleable_sample.has_role?(:sample_role_1))
  end

  def test_should_return_true_when_role_removed
    @roleable_sample.add_role(:sample_role_1)
    assert @roleable_sample.has_role?(:sample_role_1), 'Precondition: has role'
    assert @roleable_sample.remove_role(:sample_role_1)
  end

  def test_should_not_remove_role_assignment_when_removing_other_role
    @roleable_sample.add_role(:sample_role_1)
    assert_no_difference "RoleAssignment.count" do
      assert_no_difference "Role.count" do
        @roleable_sample.remove_role(:sample_role_2)
      end
    end
    assert_equal(true, @roleable_sample.has_role?(:sample_role_1))
  end

  def test_should_return_true_when_trying_to_remove_un_had_role
    assert !@roleable_sample.has_role?(:sample_role_1), 'Precondition: does not have role'
    assert @roleable_sample.remove_role(:sample_role_1)
  end

  def test_should_return_true_when_asking_if_is_existing_role
    @roleable_sample.add_role(:sample_role_1)
    assert_equal(true, @roleable_sample.sample_role_1?)
  end

  def test_should_return_false_when_asking_if_is_unexisting_role
    @roleable_sample.add_role(:sample_role_1)
    assert_equal(false, @roleable_sample.sample_role_2?)
  end

  def test_should_raise_exception_when_asking_if_is_invalid_role
    @roleable_sample.add_role(:sample_role_1)
    assert_raise(NoMethodError) {
      @roleable_sample.invalid_role?
    }
  end

end
