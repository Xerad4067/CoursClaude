-- Fichier : pourboires.lua
local total = 0                      -- l'accumulateur existe AVANT la boucle
for soir = 1, 5 do
  total = total + 12
  print("Soir " .. soir .. " : " .. total .. " €")
end
