class RobotDirectory
  def self.dataset
    database.from(:robots)
  end

  def self.add(data)
    dataset.insert(data)
  end

  def self.database
    if ENV["RACK_ENV"] == 'test'
      @database ||= Sequel.sqlite("db/robot_directory_test.sqlite3")
    else
      @database ||= Sequel.sqlite("db/robot_directory.sqlite3")
    end
  end

  def self.robots
    robots = dataset.to_a
    robots.map { |data| Robot.new(data) }
  end

  def self.all
    robots.map { |data| Robot.new(data) }
  end

  def self.get_robot(id)
    robots.find { |robot| robot["id"] == id }
  end

  def self.find(id)
    data = dataset.where(:id => id).to_a.first
    Robot.new(data)
  end

  def self.update(id, data)
    database.transaction do
      robot = database['robots'].find { |robot| robot["id"] == id}
      robot["name"] = data[:name]
      robot["city"] = data[:city]
      robot["state"] = data[:state]
      # robot["avatar"] = data[:avatar]
      robot["birthdate"] = data[:birthdate]
      robot["datehired"] = data[:datehired]
      robot["department"] = data[:department]
    end
  end

  def self.delete(id)
    database.transaction do
      database['robots'].delete_if { |robot| robot["id"] == id }
    end
  end

  def self.delete_all
    dataset.delete
  end
end
