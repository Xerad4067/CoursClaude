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

-- a < b vaut true quand le prix de a est plus petit que celui de b.
function Vehicule.__lt(a, b)
  return a.prix < b.prix
end

print(garage[3] < garage[1])         -- Scooter < Taxi
table.sort(garage)                   -- sans fonction de comparaison : sort utilise __lt

local noms = {}
for _, v in ipairs(garage) do
  table.insert(noms, v.nom)
end
print(table.concat(noms, ", "))
