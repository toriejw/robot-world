require_relative '../test_helper'

class RobotsListTest < FeatureTest
  def test_user_can_see_list_of_robots
    create_robots(3)
    visit '/robots'

    assert_equal '/robots', current_path

    assert page.has_content?("#{RobotDirectory.robots.first.id}: name 1")
    assert page.has_content?("#{RobotDirectory.robots[1].id}: name 2")
    assert page.has_content?("#{RobotDirectory.robots.last.id}: name 3")
  end

  def test_user_can_navigate_to_home
    visit '/robots'
    click_link 'home'

    assert_equal '/', current_path
  end

  def test_user_can_navigate_to_the_create_a_new_robot_page
    visit '/robots'
    click_link 'add a robot'

    assert_equal '/robots/new', current_path
  end
end
