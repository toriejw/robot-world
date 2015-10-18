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

  def test_can_return_robots_by_date_hired
    create_robots(2)
    robots_by_date_hired = RobotDirectory.group_by_date_hired

    expected = {"date hired 1" => 1, "date hired 2" => 1}

    assert_equal expected, robots_by_date_hired
  end

  def test_returns_robot_by_year_hired_only
    RobotDirectory.add({ :name => "nala",
                         :city => "Ottawa",
                         :state => "ON",
                       # :avatar => "#avatar {i}",
                         :birthdate => "unknown",
                         :datehired => "10/13/2015",
                         :department => "cat science"
                        })

    expected = {"2015" => 1}

    assert_equal expected, RobotDirectory.group_by_date_hired
  end

  def test_returns_average_robot_age
    RobotDirectory.add({ :name => "nala",
                         :city => "Ottawa",
                         :state => "ON",
                         :birthdate => "10/01/2013",
                         :datehired => "10/13/2015",
                         :department => "cat science"
                        })

    RobotDirectory.add({ :name => "genghis",
                         :city => "Ottawa",
                         :state => "ON",
                         :birthdate => "10/01/2012",
                         :datehired => "10/01/2012",
                         :department => "cat science"
                        })

    assert_equal 2.5, RobotDirectory.average_age
  end

  def test_returns_number_of_robots_in_each_department
    create_robots(2)
    expected = {"department 1" => 1, "department 2" => 1}

    assert_equal expected, RobotDirectory.group_by_department
  end

  def test_returns_number_of_robots_in_each_city
    create_robots(2)
    expected = {"city 1" => 1, "city 2" => 1}

    assert_equal expected, RobotDirectory.group_by_city
  end

  def test_returns_number_of_robots_in_each_state
    create_robots(2)
    expected = {"state 1" => 1, "state 2" => 1}

    assert_equal expected, RobotDirectory.group_by_state
  end

end
