require_relative '../test_helper'

class RobotDirectoryTest < Minitest::Test
  def create_robots(num)
    num.times do |i|
      i += 1
      RobotDirectory.add({ :name => "name #{i}",
                           :city => "city #{i}",
                           :state => "state #{i}",
                         # :avatar => "#avatar {i}",
                           :birthdate => "birthdate #{i}",
                           :date_hired => "date hired #{i}",
                           :department => "department #{i}"
                          })
    end
  end

  def test_can_add_a_robot
    create_robots(1)
    robot = RobotDirectory.find(1)

    assert_equal 1, robot.id
    assert_equal "name 1", robot.name
    assert_equal "department 1", robot.department
  end

  def test_can_find_a_robot_by_index
    create_robots(3)
    robot2 = RobotDirectory.find(2)
    robot3 = RobotDirectory.find(3)

    assert_equal 2, robot2.id
    assert_equal "name 2", robot2.name
    assert_equal "city 3", robot3.city
  end

  def test_self_can_return_list_of_all_robots
    create_robots(3)
    robots = RobotDirectory.robots

    assert_equal 3, robots.count
    assert_equal "name 2", robots[1]["name"]
  end

  def test_can_edit_a_robot
    create_robots(1)
    RobotDirectory.update(1, { :name => "nala",
                               :city => "Ottawa",
                               :state => "ON",
                             # :avatar => "#avatar {i}",
                               :birthdate => "unknown",
                               :date_hired => "today",
                               :department => "cat science"
                              })

    updated_robot = RobotDirectory.find(1)

    assert_equal "nala", updated_robot.name
    assert_equal "today", updated_robot.date_hired
    assert_equal 1, updated_robot.id
  end

  def test_can_delete_a_robot
    create_robots(3)
    RobotDirectory.delete(2)
    robots = RobotDirectory.all

    assert_equal 2, robots.count

    RobotDirectory.delete(1)
    robots = RobotDirectory.all

    assert_equal 1, robots.count

    RobotDirectory.delete(3)
    robots = RobotDirectory.all

    assert_equal [], robots
  end
end
