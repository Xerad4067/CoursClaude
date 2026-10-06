-- Fichier : garage.lua
local Vehicule = {}
Vehicule.__index = Vehicule

function Vehicule.nouveau(nom, prix)
  local v = setmetatable({}, Vehicule)
  v.nom = nom
  v.prix = prix
  return v
end

local garage = {
  Vehicule.nouveau("Taxi", 18000),
  Vehicule.nouveau("Camion", 45000),
  Vehicule.nouveau("Scooter", 3000),
  Vehicule.nouveau("Berline", 22000),
}
