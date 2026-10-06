-- Fichier : parking.lua
local places = {}                       -- une liste vide
for i = 1, 6 do
  places[#places + 1] = i * 10          -- on ajoute juste après la dernière case
end

print("Nombre de places : " .. #places)
print("Première : " .. places[1])
print("Dernière : " .. places[#places])
