class Robot
  attr_accessor :id, :name, :city, :state, :birthdate, :date_hired, :department
  def initialize(data)
    @id = data['id']
    @name = data['name']
    @city = data['city']
    @state = data['state']
  # @avatar = data['avatar']
    @birthdate = data['birthdate']
    @date_hired = data['date_hired']
    @department = data['department']
  end
end
