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
      @database ||= Sequel.sqlite("db/robot_directory_development.sqlite3")
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

  def self.group_by_date_hired
    robots.group_by { |robot| robot.datehired.split("/").last }
          .inject({}) do |output, (count, robots)|
            output[count] = robots.count
            output
          end
  end

  def self.average_age
    ages_sum = robots.map { |robot| Time.now.year - robot.birthdate.split("/").last.to_i }
                           .reduce(:+)
    average_age = ages_sum.to_f/robots.count
  end

  def self.group_by_department
    robots.group_by { |robot| robot.department }
          .inject({}) do |output, (count, robots)|
            output[count] = robots.count
            output
          end
  end

  def self.group_by_city
    robots.group_by { |robot| robot.city }
          .inject({}) do |output, (count, robots)|
            output[count] = robots.count
            output
          end
  end

  def self.group_by_state
    robots.group_by { |robot| robot.state }
          .inject({}) do |output, (count, robots)|
            output[count] = robots.count
            output
          end
  end
end
