require_relative '../test_helper'

class IndividualPageTest < FeatureTest
  def test_user_can_click_on_each_robot
    create_robots(1)
    visit '/robots'
    # save_and_open_page  
    click_button '1: name 1'
    assert_equal '/robots/1', current_path
  end
end
