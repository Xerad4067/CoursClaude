-- Fichier : roues.lua
local Vehicule = {}
Vehicule.__index = Vehicule
Vehicule.roues = 4                    -- valeur partagée, rangée dans la classe

function Vehicule.nouveau(nom)
  return setmetatable({ nom = nom }, Vehicule)
end

local voiture = Vehicule.nouveau("Berline")
local camion = Vehicule.nouveau("Camion")
camion.roues = 6                      -- on écrit dans l'objet camion, pas dans la classe

print(voiture.roues)
print(camion.roues)
print(Vehicule.roues)
print(rawget(voiture, "roues"))
