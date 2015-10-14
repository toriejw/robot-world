require_relative '../test_helper.rb'

class RobotTest < Minitest::Test
  def test_has_expected_attributes
    robot = Robot.new({'id' => 1,
                       'name'       => 'Nala',
                       'city'       => 'Ottawa',
                       'state'      => 'Ontario',
                       'birthdate'  => 'unknown',
                       'date_hired' => 'oct 2014',
                       'department' => 'cat science' })

    assert_equal 1, robot.id
    assert_equal 'Nala', robot.name
    assert_equal 'Ottawa', robot.city
    assert_equal 'Ontario', robot.state
    assert_equal 'unknown', robot.birthdate
    assert_equal 'oct 2014', robot.date_hired
    assert_equal 'cat science', robot.department
  end
end
