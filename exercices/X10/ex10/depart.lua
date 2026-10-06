-- Fichier : tarif.lua
local Tarif = {}
Tarif.__index = Tarif

function Tarif.nouveau(base, prixKm)
  return setmetatable({ base = base, prixKm = prixKm }, Tarif)
end
