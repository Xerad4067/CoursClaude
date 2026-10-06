-- Fichier : permis.lua
local age = 17
if age >= 18 then
  print("Tu peux passer le permis")
else
  print("Encore " .. 18 - age .. " an(s) à attendre")
end
