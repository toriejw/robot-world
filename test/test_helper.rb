ENV['RACK_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'tilt/erb'

class Minitest::Test
  def teardown
    RobotDirectory.delete_all
  end
end

Capybara.app = RobotDirectoryApp

class FeatureTest < Minitest::Test
  include Capybara::DSL

  def create_robots(num)
    num.times do |i|
      i += 1
      RobotDirectory.add({ :name => "name #{i}",
                           :city => "city #{i}",
                           :state => "state #{i}",
                         # :avatar => "#avatar {i}",
                           :birthdate => "birthdate #{i}",
                           :date_hired => "date hired #{i}",
                           :department => "department #{i}"
                          })
    end
  end
end
