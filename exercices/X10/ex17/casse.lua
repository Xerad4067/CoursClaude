-- Fichier : camion.lua
local Vehicule = {}
Vehicule.__index = Vehicule
Vehicule.__tostring = function(self)
  return self.nom .. " (" .. self.vitesse .. " km/h)"
end

function Vehicule.nouveau(nom, vitesse)
  return setmetatable({ nom = nom, vitesse = vitesse }, Vehicule)
end

local Camion = setmetatable({}, { __index = Vehicule })
Camion.__index = Camion

function Camion.nouveau(nom, vitesse, charge)
  local c = Vehicule.nouveau(nom, vitesse)
  c.charge = charge
  return setmetatable(c, Camion)
end

print(Vehicule.nouveau("Taxi", 120))
print(Camion.nouveau("Citerne", 80, 12))
