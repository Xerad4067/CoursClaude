-- Fichier : location.lua
local argent = 80
local aLePermis = true
if aLePermis then
  if argent >= 100 then
    print("Location acceptée")
  else
    print("Il te manque " .. 100 - argent .. " €")
  end                          -- ferme le if sur l'argent
else
  print("Il faut le permis")
end                            -- ferme le if sur le permis
