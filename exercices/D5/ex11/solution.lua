-- Fichier : parc.lua
local Vehicule = {}
Vehicule.__index = Vehicule

function Vehicule.nouveau(plaque)
  local v = setmetatable({}, Vehicule)
  v.plaque = plaque
  return v
end

function Vehicule:decrire()
  return "Véhicule " .. self.plaque
end

-- « class Camion(Vehicule) » : Camion cherche dans Vehicule ce qu'il n'a pas
local Camion = setmetatable({}, { __index = Vehicule })
Camion.__index = Camion

function Camion.nouveau(plaque, nbEssieux)
  local c = Vehicule.nouveau(plaque)  -- l'équivalent de super().__init__(plaque)
  setmetatable(c, Camion)             -- puis l'objet devient un Camion
  c.nbEssieux = nbEssieux
  return c
end

function Camion:decrire()  -- redéfinition
  -- l'équivalent de super().decrire() : on appelle la version de la mère
  return Vehicule.decrire(self) .. " (" .. self.nbEssieux .. " essieux)"
end

local voiture = Vehicule.nouveau("AB-123-CD")
local camion = Camion.nouveau("XY-987-ZT", 3)
print(voiture:decrire())
print(camion:decrire())
