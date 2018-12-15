arr = [1, 1]
i = 0

while arr[i] + arr[i + 1] < 100
  arr.push(arr[i] + arr[i + 1])
  i += 1
end

print arr
