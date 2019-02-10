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



class Route
  def initialize(first, last)
    @stations = Array.new
    @stations << first << last
  end

  def first
    return @stations[0]
  end
  def last
    return @stations[-1]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    station.current_trains.each do |train|
      if train.current_route == self
        train.move_back
      end
    end
    @stations.delete(station)
  end

  def next(station_index)
    return @stations[station_index + 1]
  end

  def prev(station_index)
    return @stations[station_index - 1]
  end

  def list
    @stations.each do |st|
      print " -> ", st.name
    end
    puts
  end
  attr_reader :stations
end



class Train
  def initialize(number, type = "cargo", number_of_wagons = 0)
    @number = number
    if type != "cargo"
      @type = "passenger"
    else
      @type = "cargo"
    end
    @number_of_wagons = number_of_wagons.to_i
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

  def number_of_wagons; @number_of_wagons; end
  def wagon_plus
    if @speed == 0
      @number_of_wagons += 1
    else
      puts "Нельзя прицеплять вагоны на ходу!"
    end
  end
  def wagon_minus
    if @number_of_wagons == 0
      puts "Нечего отцеплять"
    elsif @speed == 0
      @number_of_wagons -= 1
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
