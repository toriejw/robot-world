require_relative '../test_helper'

class HomePageTest < FeatureTest
  def test_user_sees_a_greeting
    skip
    visit '/'
    assert_equal '/', current_path
    assert page.has_content?('robot directory')
  end

  def test_user_can_navigate_to_robot_index
    skip
    visit '/'
    click_link 'View Robots'
    assert_equal '/robots', current_path
  end

  def test_user_can_navigate_to_the_create_a_new_robot_page
    skip
    visit '/'
    click_link 'Add a Robot'
    assert_equal '/robots/new', current_path
  end
end
