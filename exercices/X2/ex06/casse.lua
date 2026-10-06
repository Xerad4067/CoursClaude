-- Fichier : jauge.lua
local essence = 20

if essence > 50 then
  print("Réservoir presque plein")
else if essence > 10 then
  print("Réservoir à moitié vide")
else
  print("Réserve : cherche une station")
end
