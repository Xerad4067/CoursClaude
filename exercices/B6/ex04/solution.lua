-- Fichier : garage.lua
local garage = { "Sultan", "Taxi", "Camion" }
for i = 1, #garage do        -- de 1 à la taille de la liste
  print(i .. " : " .. tostring(garage[i]))
end
