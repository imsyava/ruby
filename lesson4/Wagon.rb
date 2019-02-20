class PassengerWagon
  def initialize(number)
    @number = number.to_s
    @type = "passenger"
  end

  attr_reader :type
end

class CargoWagon
  def initialize(number)
    @number = number.to_s
    @type = "cargo"
  end

  attr_reader :type
end
