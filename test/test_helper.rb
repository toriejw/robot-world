ENV['RACK_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'

class Minitest::Test
  def teardown
    RobotDirectory.delete_all
  end
end
