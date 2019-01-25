require_relative 'Station.rb' 

st1 = Station.new("Казань")
st2 = Station.new("Санкт-Петербург")
route = Route.new(st1, st2)
st3 = Station.new("Москва")
route.add_station(st3)
st4 = Station.new("Тверь")
st5 = Station.new("Бологое")
route.add_station(st4)
route.add_station(st5)
train = Train.new("first_train", "passenger", "1")
train.take_route(route)

puts train.station_current, train.number_of_wagons
route.list
puts train.station_prev
puts train.station_next

train.wagon_minus
print train.number_of_wagons, " "
train.wagon_minus
print train.number_of_wagons, " "
train.wagon_plus
puts train.number_of_wagons
train.speed_up(10)
train.wagon_minus
print train.number_of_wagons, " "
train.wagon_plus
puts train.number_of_wagons
print train.type, " ", train.speed, " "
train.stop
puts train.speed

train.info

route.delete_station(st4)
route.list

print st1.current_trains, " "
st1.take(train)
print st1.current_trains, " "
#print st1.current_cargo_trains, " ", st1.current_passenger_trains, " "
st1.send(train)
#print st1.current_trains, " ", st1.current_cargo_trains, " ", st1.current_passenger_trains, " "
