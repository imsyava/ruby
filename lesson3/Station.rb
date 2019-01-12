class Station
  def initialization(name)
    @name = name
  end

  def take(train)
    @current_trains << train
    if train.type == "cargo"
      @current_cargo_trains << train
    else
      @current_passenger_trains << train
    end
  end

  def current_trains; @current_trains; end
  def current_cargo_trains; @current_cargo_trains; end
  def current_passenger_trains; @current_passenger_trains; end

  def send
    if @current_trains[-1].type == "cargo"
      @current_cargo_trains[-1].delete
      @current_trains[-1].delete
    else
      @current_passenger_trains[-1].delete
      @current_trains[-1].delete
    end
  end
end



class Train
  def initialization(number, type = "cargo", number_of_wagons = 0)
    @number = number
    if type != "cargo"
      @type = "passenger"
    else
      @type = "cargo"
    end
    @number_of_wagons = number_of_wagons
  end

  def type; @type; end

  def speed; @speed; end
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
    if @speed == 0
      @number_of_wagons -= 1
    elsif @number_of_wagons == 0
      puts "Нечего отцеплять"
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
      @current_route.next(@current_station)
    end
  end

  def station_prev
    if @current_route.first == @current_station
      puts "Поезд находится на начальной станции"
    elsif @current_route == nil
      puts "Поезду ещё не назначен маршрут"
    else
      @current_route.prev(@current_station)
    end
  end
end



class Route
  def initialization(first, last)
    @first = first
    @last = last
    @middle_stations = Array.new
  end

  def add_station(station)
    @middle_stations << station
  end

  def delete_station(station)
    @middle_stations.delete(station)
  end

  def next(station)
    if station == @first && @middle_stations.length == 0
      return @last
    elsif station == @first
      return @middle_stations.first
    else
      @middle_stations.each_with_index do |stat, index|
        if stat == station
          if index == @middle_stations.length - 1
            return @last
          else
            return @middle_stations[index + 1]
          end
        end
      end
    end
  end

  def prev(station)
    if station == @last && @middle_stations.length == 0
      return @first
    elsif station == @last
      return @middle_stations.last
    else
      @middle_stations.each_with_index do |stat, index|
        if stat == station
          if index == 0
            return @first
          else
            return @middle_stations[index - 1]
          end
        end
      end
    end
  end
end
