require_relative '../test_helper'

class HomePageTest < FeatureTest
  def test_user_sees_a_greeting
    visit '/'
    assert_equal '/', current_path
    assert page.has_content?('robot directory')
  end

  def test_user_can_navigate_to_robot_index
    visit '/'
    click_link 'View Robots'
    assert_equal '/robots', current_path
  end

  def test_user_can_navigate_to_the_create_a_new_robot_page
    visit '/'
    click_link 'Add a Robot'
    assert_equal '/robots/new', current_path
  end

  def test_user_sees_number_of_robots_hired_each_year
    # date formatting should be standardized
    create_robots(2)
    visit '/'

    assert page.has_content?('Number of robots hired by year:')
    assert page.has_content?('date hired 1: 1')
    assert page.has_content?('date hired 2: 1')
  end

  def test_user_sees_average_robot_age
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

    visit '/'

    assert page.has_content?('Average robot age:')
    assert page.has_content?('2.5')
  end

  def test_user_sees_number_of_robots_in_each_department
    create_robots(2)
    visit '/'

    assert page.has_content?('Number of robots in each department:')
    assert page.has_content?('department 1: 1')
    assert page.has_content?('department 2: 1')
  end

  def test_user_sees_number_of_robots_in_each_city
    create_robots(2)
    visit '/'

    assert page.has_content?('Number of robots in each city:')
    assert page.has_content?('city 1: 1')
    assert page.has_content?('city 2: 1')
  end

  def test_user_sees_number_of_robots_in_each_state
    create_robots(2)
    visit '/'

    assert page.has_content?('Number of robots in each state:')
    assert page.has_content?('state 1: 1')
    assert page.has_content?('state 2: 1')
  end
end
