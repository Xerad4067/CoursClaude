-- Fichier : garage.lua
local function afficherVehicule(nom, vitesse)
  if vitesse > 100 then
    print(nom .. " est rapide")
  else
    print(nom .. " est calme")
  end                          -- ferme le if
end                            -- ferme la fonction

afficherVehicule("Sultan", 160)
afficherVehicule("Scooter", 45)
