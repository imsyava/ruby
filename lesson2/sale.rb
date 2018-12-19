names = "---"
cost = 0.0
count = 0.0
cart = {}

loop do
  print "Наименование: "
  names = gets.chomp
  if names == "stop" || names == "стоп"
    break
  end
  print "Стоимость: "
  cost = gets.chomp.to_f
  print "Количество: "
  count = gets.chomp.to_f
  
  cart[names] = {cost: cost, count: count}
end

sum = 0
cart.each do |item, properties|
  s = properties[:cost] * properties[:count]
  puts "#{item} кол-во: #{properties[:count]} цена: #{properties[:cost]} стоимость: #{s}"
  sum += s
end
puts "Общая стоимость: #{sum}"
