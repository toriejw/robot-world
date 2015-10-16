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

  def self.get_robot(id)
    robots.find { |robot| robot["id"] == id }
  end

  def self.find(id)
    data = dataset.where(:id => id).to_a.first
    Robot.new(data)
  end

  def self.update(id, data)
    dataset.where(:id => id).update(data)
  end

  def self.delete(id)
    dataset.where(:id => id).delete
  end

  def self.delete_all
    dataset.delete
  end
end
