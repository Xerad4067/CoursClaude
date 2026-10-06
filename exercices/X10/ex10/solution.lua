-- Fichier : tarif.lua
local Tarif = {}
Tarif.__index = Tarif

function Tarif.nouveau(base, prixKm)
  return setmetatable({ base = base, prixKm = prixKm }, Tarif)
end

-- Appelée pour tarif(km) : le premier paramètre est l'objet lui-même.
function Tarif:__call(km)
  return self.base + self.prixKm * km
end

local taxi = Tarif.nouveau(3, 2)
print(taxi(10))
print(taxi(0))
local limousine = Tarif.nouveau(10, 5)
print(limousine(4))
