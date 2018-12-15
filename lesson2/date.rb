months = { 1 => 31, 2 => 28, 3 => 31,
  4 => 30, 5 => 31, 6 => 30,
  7 => 31, 8 => 31, 9 => 30,
  10 => 31, 11 => 30, 12 => 31}

print "Введите день: "
d = gets.chomp.to_i
print "Введите месяц: "
m = gets.chomp.to_i
print "Введите год: "
y = gets.chomp.to_i
check_d = true
check_m = true
leap_year = false

if (1..12).any? { |i| i == m }
  check_m = true
else
  check_m = false
  puts "Введён некорректный номер месяца"
end

if (y % 4 == 0 && (y % 100 != 0 || y % 400 == 0))
  leap_year = true
end

if m == 2 && leap_year && (1..29).any? { |i| i == d }
  check_d = true
elsif check_m
  if (1..months[m]).any? { |i| i == d }
    check_d = true
  else
    check_d = false
    puts "Введён некорректный номер дня"
  end
end

total_number = 0
m_counter = 1

while m_counter < m && check_m
  total_number += months[m_counter]
  m_counter += 1
end
if check_d
  total_number += d
end
if leap_year && m > 2
  total_number += 1
end

if check_d && check_m
  puts total_number
end
