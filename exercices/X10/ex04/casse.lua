-- Fichier : vehicule.lua
local Vehicule = {}

function Vehicule.nouveau(nom)
  local v = setmetatable({}, Vehicule)
  v.nom = nom
  return v
end

function Vehicule:rouler(km)
  return self.nom .. " roule " .. km .. " km"
end

local taxi = Vehicule.nouveau("Taxi")
print(taxi:rouler(12))
