class Station
  def initialize(names)
    @name = names
    @current_trains = []
    @current_cargo_trains = []
    @current_passenger_trains = []
  end

  attr_reader :name

  def take(train)
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

  def send(train)
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
    @first = first
    @last = last
    @stations = Array.new
    @stations << @first << @last
  end

  attr_reader :first
  attr_reader :last

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def next(station)
    @stations.each_with_index do |stat, index|
      if stat == station
        return @stations[index + 1]
      end
    end
  end

  def prev(station)
    @stations.each_with_index do |stat, index|
      if stat == station
        return @stations[index - 1]
      end
    end
  end

  def list
    @stations.each do |st|
      print " -> ", st.name
    end
    puts
  end
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
  end

  attr_reader :type
  attr_reader :speed

  def speed_up(count)
    @speed += count
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
    @current_station = route.first
  end

  def station_current; @current_station; end

  def station_next
    if @current_route.last == @current_station
      puts "Поезд уже достиг конечной станции"
    elsif @current_route == nil
      puts "Поезду ещё не назначен маршрут"
    else
      @current_route.next(@current_station).name
    end
  end

  def station_prev
    if @current_route.first == @current_station
      puts "Поезд находится на начальной станции"
    elsif @current_route == nil
      puts "Поезду ещё не назначен маршрут"
    else
      @current_route.prev(@current_station).name
    end
  end

  def move
    if @current_route.last == @current_station
      puts "Поезд находится на конечной станции"
    elsif @current_route == nil
      puts "Поезду ещё не назначен маршрут"
    else 
      self.speed_up(100)
      @current_station.send(self)
      @current_station = @current_route.next(@current_station)
      @current_station.take(self)
      self.stop
    end
  end


  def info
    puts "Номер поезда: #{@number}"
    puts "Тип поезда: #{@type}"
    puts "Текущая скорость #{@speed}"
    puts "Сейчас вагонов: #{@number_of_wagons}"
    puts "Текущий маршрут: #{@current_route.first.name} -> #{@current_route.last.name}"
    puts "Текущая станция: #{@current_station.name}"
  end
end
