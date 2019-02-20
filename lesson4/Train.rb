require_relative 'Station.rb'
require_relative 'Route.rb'
require_relative 'Wagon.rb'
#require_relative 'PassengerTrain.rb'
#require_relative 'CargoTrain.rb'

class Train
  def initialize(number, type = "cargo")
    @number = number.to_s
    if type != "cargo"
      @type = "passenger"
    else
      @type = "cargo"
    end
    @wagons = []
    @speed = 0
    @station_index = nil
  end

  attr_reader :type
  attr_reader :speed

  def speed_up(count)
    @speed += count.to_i
  end
  def stop
    @speed = 0
  end

  def number_of_wagons
    @wagons.count
  end

  def wagon_plus(wagon)
    if wagon.type != self.type
      puts "Вагон этого типа нельзя присоединить к этому поезду"
    elsif @speed == 0
      @wagons << wagon
    else
      puts "Нельзя прицеплять вагоны на ходу!"
    end
  end

  def wagon_minus
    if @wagons.empty?
      puts "Нечего отцеплять"
    elsif @speed == 0
      @wagons.delete_at(-1)
    else
      puts "Нельзя отцеплять вагоны на ходу!"
    end
  end

  def take_route(route)
    @current_route = route
    @station_index = 0
    @current_station = route.first
    @current_station.take_train(self)
  end

  attr_reader :current_station
  attr_reader :current_route

  def station_next
    if @current_route == nil
      puts "Поезду ещё не назначен маршрут"
    elsif @current_route.last == @current_station
      puts "Поезд уже достиг конечной станции"
    else
      @current_route.next(@station_index).name
    end
  end

  def station_prev
    if @current_route == nil
      puts "Поезду ещё не назначен маршрут"
    elsif @current_route.first == @current_station
      puts "Поезд находится на начальной станции"
    else
      @current_route.prev(@station_index).name
    end
  end

  def move_forward
    if @current_route == nil
      puts "Поезду ещё не назначен маршрут"
    elsif @current_route.last == @current_station
      puts "Поезд уже достиг конечной станции маршрута и теперь отправляется в депо"
      @current_route = nil
      @station_index = nil
      @current_station.send_train(self)
      @current_station = nil
    else 
      self.speed_up(100)
      @current_station.send_train(self)
      @current_station = @current_route.next(@station_index)
      @station_index += 1
      @current_station.take_train(self)
      self.stop
    end
  end

  def move_back
    if @current_route == nil
      puts "Поезду ещё не назначен маршрут"
    elsif @current_route.first == current_station
      puts "Поезд находится на начальной станции своего маршрута"
    else
      self.speed_up(100)
      @current_station.send_train(self)
      @current_station = @current_route.prev(@station_index)
      @station_index -= 1
      @current_station.take_train(self)
      self.stop
    end
  end


  def info
    puts "----------"
    puts "Номер поезда: #{@number}"
    puts "Тип поезда: #{@type}"
    puts "Текущая скорость #{@speed}"
    puts "Сейчас вагонов: #{@number_of_wagons}"
    if @current_route == nil
      puts "Маршрут ещё не назначен"
    else
      print "Текущий маршрут: "
      @current_route.list
    end
    if @current_station == nil
      puts "Поезд сейчас находится в депо"
    else
      puts "Текущая станция: #{@current_station.name}"
    end
    puts "----------"
  end
end

class CargoTrain < Train
  def initialize(number)
    @number = number.to_s
    @type = "cargo"
    @wagons = []
    @speed = 0
    @station_index = nil
  end
end

class PassengerTrain < Train
  def initialize(number)
    @number = number.to_s
    @type = "passenger"
    @wagons = []
    @speed = 0
    @station_index = nil
  end
end
