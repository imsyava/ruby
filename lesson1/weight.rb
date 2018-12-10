puts "Hi! What's your name?"
name = gets.chomp
puts "And what's your height?"
height = gets.chomp.to_i
if height - 110 <= 0
  puts "#{name}, you already have optimal weight."
else
  puts "#{name}, your optimal weight = #{height - 110}"
end
