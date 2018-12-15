h = Hash.new
letters = ["a", "e", "i", "o", "u", "y"]
count = 1

for i in ("a".."z")
  if letters.any? { |letter| i == letter }
    h[i] = count
  end
  count += 1
end

print h
