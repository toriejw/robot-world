require_relative '../test_helper'

class DeleteRobotsTest < FeatureTest
  def test_user_can_delete_a_robot
    skip
    create_robots(1)

    visit '/robots'
    click_button 'delete'

    assert_equal '/robots', current_path

    refute page.has_content? '1: name 1'
  end
end
