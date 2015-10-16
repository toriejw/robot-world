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
                           :datehired => "date hired #{i}",
                           :department => "department #{i}"
                          })
    end
  end

  def test_can_add_a_robot
    create_robots(1)
    robot = RobotDirectory.find(RobotDirectory.robots.first.id)

    assert_equal RobotDirectory.robots.first.id, robot.id
    assert_equal "name 1", robot.name
    assert_equal "department 1", robot.department
  end

  def test_can_find_a_robot_by_index
    create_robots(3)
    robot2 = RobotDirectory.find(RobotDirectory.robots[1].id)
    robot3 = RobotDirectory.find(RobotDirectory.robots.last.id)

    assert_equal RobotDirectory.robots[1].id, robot2.id
    assert_equal "name 2", robot2.name
    assert_equal "city 3", robot3.city
  end

  def test_self_can_return_list_of_all_robots
    create_robots(3)
    robots = RobotDirectory.robots

    assert_equal 3, robots.count
    assert_equal "name 2", robots[1].name
  end

  def test_can_edit_a_robot
    create_robots(1)
    robot_id = RobotDirectory.robots.first.id
    RobotDirectory.update(robot_id, { :name => "nala",
                                      :city => "Ottawa",
                                      :state => "ON",
                                    # :avatar => "#avatar {i}",
                                      :birthdate => "unknown",
                                      :datehired => "today",
                                      :department => "cat science"
                                     })

    updated_robot = RobotDirectory.robots.first
    assert_equal "nala", updated_robot.name
    assert_equal "today", updated_robot.datehired
    assert_equal robot_id, updated_robot.id
  end

  def test_can_delete_a_robot
    create_robots(3)
    RobotDirectory.delete(RobotDirectory.robots[1].id)
    robots = RobotDirectory.robots

    assert_equal 2, robots.count

    RobotDirectory.delete(RobotDirectory.robots.first.id)
    robots = RobotDirectory.robots

    assert_equal 1, robots.count

    RobotDirectory.delete(RobotDirectory.robots.last.id)
    robots = RobotDirectory.robots

    assert_equal [], robots
  end
end
