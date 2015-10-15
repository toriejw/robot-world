require_relative '../test_helper'

class IndividualPageTest < FeatureTest
  def test_user_can_click_on_each_robot
    create_robots(1)
    visit '/robots'
    click_link '1: name 1'
    
    assert_equal '/robots/1', current_path
  end
end
