require_relative '../test_helper'

class DeleteRobotsTest < FeatureTest
  def test_user_can_delete_a_robot
    create_robots(1)
    robot_id = RobotDirectory.robots.first.id

    visit '/robots'
    click_button 'delete'

    assert_equal '/robots', current_path

    refute page.has_content? "#{robot_id}: name #{robot_id}"
  end
end
