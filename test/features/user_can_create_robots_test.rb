require_relative '../test_helper'

class CreateRobotTest < FeatureTest
  def test_user_can_navigate_to_new_robot_page_from_home
    visit '/'
    click_link 'Add a Robot'

    assert_equal '/robots/new', current_path
  end

  def test_user_can_navigate_to_new_robot_page_from_index
    visit '/robots'
    click_link 'add a robot'

    assert_equal '/robots/new', current_path
  end

  def test_user_can_add_a_robot
    visit '/robots/new'
    assert_equal '/robots/new', current_path

    fill_in("robot[name]", with: "nala")
    fill_in("robot[city]", with: "ottawa")
    fill_in("robot[state]", with: "ontario")
    fill_in("robot[birthdate]", with: "10/24/92")
    fill_in("robot[datehired]", with: "today")
    fill_in("robot[department]", with: "comp sci")
    click_button 'Submit'

    assert_equal '/robots', current_path
    assert page.has_content?("#{RobotDirectory.robots.first.id}: nala")
  end

  def test_when_user_adds_a_robot_all_attributes_are_saved
    visit '/robots/new'

    fill_in("robot[name]", with: "nala")
    fill_in("robot[city]", with: "ottawa")
    fill_in("robot[state]", with: "ontario")
    fill_in("robot[birthdate]", with: "10/24/92")
    fill_in("robot[datehired]", with: "today")
    fill_in("robot[department]", with: "comp sci")
    click_button 'Submit'

    click_link "#{RobotDirectory.robots.first.id}: nala"

    assert page.has_content?('nala')
    assert page.has_content?('City: ottawa, ontario')
    assert page.has_content?('Birthday: 10/24/92')
    assert page.has_content?('Date hired: today')
    assert page.has_content?('Department: comp sci')
  end
end
