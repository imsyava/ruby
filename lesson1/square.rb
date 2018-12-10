print "Enter a: "
a = gets.chomp.to_f
print "Enter b: "
b = gets.chomp.to_f
print "Enter c: "
c = gets.chomp.to_f

d = b**2 - 4*a*c

if d < 0
  puts "Корней нет, потому что D = #{d}"
elsif d == 0
  x = -b/(2*a)
  puts "x = #{x}, D = #{d}"
else
  x1 = (Math.sqrt(d)-b)/(2*a)
  x2 = (-Math.sqrt(d)-b)/(2*a)
  puts "x1 = #{x1}, x2 = #{x2}, D = #{d}"
end
