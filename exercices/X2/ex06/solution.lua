-- Fichier : jauge.lua
local essence = 20

if essence > 50 then
  print("Réservoir presque plein")
elseif essence > 10 then              -- elseif en UN seul mot : pas de second if, donc pas de second end
  print("Réservoir à moitié vide")
else
  print("Réserve : cherche une station")
end
