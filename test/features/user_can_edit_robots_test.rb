require_relative '../test_helper'

class EditRobotsTest < FeatureTest
  def test_user_can_get_to_edit_page_from_index_page
    create_robots(1)
    visit '/robots'
    click_link 'edit'

    assert_equal "/robots/#{RobotDirectory.robots.first.id}/edit", current_path
  end

  def test_user_can_update_robot_attributes
    create_robots(1)
    visit '/robots'
    click_link 'edit'

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
