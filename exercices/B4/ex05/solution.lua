-- Fichier : lecture.lua
local n = 1
while n < 50 do
  n = n * 3
end
print(n)

for i = 1, 10 do
  if i % 4 == 0 then break end
  print(i)
end

local k = 0
repeat
  k = k + 2
until k >= 5
print(k)
