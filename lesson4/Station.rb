require_relative 'Train.rb'

class Station
  def initialize(names)
    @name = names
    @current_trains = []
    @current_cargo_trains = []
    @current_passenger_trains = []
  end

  attr_reader :name

  def take_train(train)
    @current_trains << train
    if train.type == "cargo"
      @current_cargo_trains << train
    else
      @current_passenger_trains << train
    end
  end

  attr_reader :current_trains
  attr_reader :current_passenger_trains
  attr_reader :current_cargo_trains

  def send_train(train)
    if train.type == "cargo"
      @current_cargo_trains.delete(train)
      @current_trains.delete(train)
    else
      @current_passenger_trains.delete(train)
      @current_trains.delete(train)
    end
  end
end
