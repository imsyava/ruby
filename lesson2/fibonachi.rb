arr = [1, 1]

while arr[-1] + arr[-2] < 100
  arr << arr[-1] + arr[-2]
end

print arr
