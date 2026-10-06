-- Fichier : camion.lua
local Vehicule = {}
Vehicule.__index = Vehicule

function Vehicule.nouveau(nom, vitesse)
  local v = setmetatable({}, Vehicule)
  v.nom = nom
  v.vitesse = vitesse
  return v
end

function Vehicule:decrire()
  return self.nom .. " roule à " .. self.vitesse .. " km/h"
end
