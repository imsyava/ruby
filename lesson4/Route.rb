require_relative 'Station.rb'
require_relative 'Train.rb'

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
