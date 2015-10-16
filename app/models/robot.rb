class Robot
  attr_accessor :id, :name, :city, :state, :birthdate, :datehired, :department
  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @city = data[:city]
    @state = data[:state]
  # @avatar = data[:avatar]
    @birthdate = data[:birthdate]
    @datehired = data[:datehired]
    @department = data[:department]
  end
end
