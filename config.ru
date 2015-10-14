require 'bundler'
Bundler.require

$LOAD_PATH.unshift(File.expand_path("app", __dir__)) # adds another place to look in load_path which is an array of paths

require 'controllers/robot_directory_app'

run RobotDirectoryApp
