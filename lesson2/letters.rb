h = Hash.new
letters = ["a", "e", "i", "o", "u", "y"]

("a".."z").each_with_index do |letter, index|
  if letters.any? { |l| l == letter }
    h[letter] = index + 1
  end
end

print h
