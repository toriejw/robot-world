require_relative '../test_helper'

class IndividualPageTest < FeatureTest
  def test_user_can_click_on_each_robot
    create_robots(1)
    robot_id = RobotDirectory.robots.first.id

    visit '/robots'
    click_link "#{robot_id}: name 1"

    assert_equal "/robots/#{robot_id}", current_path
  end

  def test_individual_pages_have_the_robots_information
    create_robots(1)
    visit "/robots/#{RobotDirectory.robots.first.id}"

    assert page.has_content?('name 1')
    assert page.has_content?('City: city 1, state 1')
    assert page.has_content?('Birthday: birthdate 1')
    assert page.has_content?('Date hired: date hired 1')
    assert page.has_content?('Department: department 1')
  end
end
