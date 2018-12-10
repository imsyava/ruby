print "Enter a: "
a = gets.chomp.to_f
print "Enter b: "
b = gets.chomp.to_f
print "Enter c: "
c = gets.chomp.to_f

if a > b && a > c
  max = a
  square = a**2 == b**2 + c**2
elsif b > a && b > c
  max = b
  square = b**2 == a**2 + c**2
elsif c > a && c > b
  max = c
  square = c**2 == a**2 + b**2
else
  square = false
  #в прямоугольном треугольнике не может быть двух гипотенуз
end

if (a == b && a != c) 
  equal_a_b = true
  equal_a_c = false
  equal_b_c = false
elsif (a == c && a != b)
  equal_a_b = false
  equal_a_c = true
  equal_b_c = false
elsif (c == b && a != c)
  equal_a_b = false
  equal_a_c = false
  equal_b_c = true
elsif (a == b && a == c)
  equal_a_b = true
  equal_a_c = true
  equal_b_c = true
else
  equal_a_b = false
  equal_a_c = false
  equal_b_c = false
end

if equal_a_b && equal_b_c
  puts "Треугольник равносторонний"
elsif square && (equal_a_b||equal_a_c||equal_b_c)
  puts "Треугольник прямоугольный и равнобедренный"
elsif !square && (equal_a_b||equal_a_c||equal_b_c)
  puts "Треугольник не прямоугольный, но равнобедренный"
elsif square && !(equal_a_b||equal_a_c||equal_b_c)
  puts "Треугольник прямоугольный, но не равнобедренный"
else
  puts "Треугольник не прямоугольный, и не равнобедренный"
end
