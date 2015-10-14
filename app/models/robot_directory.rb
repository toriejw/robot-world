require 'yaml/store'
require_relative 'robot'

class RobotDirectory
  def self.add(robot)
    database.transaction do
      database['robots'] ||= []
      database['total']  ||= 0
      database['total']  += 1
      database['robots'] << {"id" => database['total'],
                             "name" => robot[:name],
                             "city" => robot[:city],
                             "state" => robot[:state],
                            #  "avatar" => robot[:avatar],
                             "birthdate" => robot[:birthdate],
                             "date hired" => robot[:date_hired],
                             "department" => robot[:department]
                            }
    end
  end

  def self.database
    @database ||= YAML::Store.new("db/robot_directory")
  end

  def self.robots
    database.transaction do
      database['robots'] || []
    end
  end

  def self.all
    robots.map { |data| Robot.new(data) }
  end

  def self.get_robot(id)
    robots.find { |robot| robot["id"] == id }
  end

  def self.find(id)
    Robot.new(get_robot(id))
  end

  def self.update(id, data)
    database.transaction do
      robot = database['robots'].find { |robot| robot["id"] == id}
      robot["name"] = data[:name]
      robot["city"] = data[:city]
      robot["state"] = data[:state]
      # robot["avatar"] = data[:avatar]
      robot["birthdate"] = data[:birthdate]
      robot["date hired"] = data[:date_hired]
      robot["department"] = data[:department]
    end
  end

  def self.delete(id)
    database.transaction do
      database['robots'].delete_if { |robot| robot["id"] == id }
    end
  end
end
