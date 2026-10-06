-- Fichier : garage.lua
local garage = { "Sultan", "Taxi", "Camion" }
for i = 0, #garage - 1 do
  print(i .. " : " .. tostring(garage[i]))
end
