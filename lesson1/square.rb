print "Enter a: "
a = Integer(gets.chomp)
print "Enter b: "
b = Integer(gets.chomp)
print "Enter c: "
c = Integer(gets.chomp)

d = b**2 - 4*a*c

if d < 0
	puts "Корней нет, потому что D = #{d}"
elsif d == 0
	puts "x = #{-b/(2*a)}, D = #{d}"
else
	puts "x1 = #{(Math.sqrt(d)-b)/(2*a)}, x2 = #{(-Math.sqrt(d)-b)/(2*a)}, D = #{d}"
end